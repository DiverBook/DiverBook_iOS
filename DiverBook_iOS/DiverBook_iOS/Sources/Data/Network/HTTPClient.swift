//
//  HTTPClient.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/28/25.
//
import Foundation

protocol HTTPClient {
    func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type, session: URLSession?) async
        -> Result<T, RequestError>
}

extension HTTPClient {
    func request<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type,
        session: URLSession? = nil
    ) async -> Result<T, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(
                withJSONObject: body as [String: Any], options: [])
        }

        do {
            var data: Data?
            var urlResponse: URLResponse?
            if let session = session {
                (data, urlResponse) = try await session.data(for: request, delegate: DiverBookURLSessionDelegate.init())
            }
            else {
                (data, urlResponse) = try await URLSession.shared.data(
                    for: request, delegate: nil)
            }
            
            guard let data = data, let urlResponse = urlResponse else {
                return .failure(.unknown)
            }
            
            guard let response = urlResponse as? HTTPURLResponse else {
                return .failure(.decode)
            }

            print(response.allHeaderFields)
            
            switch response.statusCode {
            case 200...299:
                guard
                    let decodeResponse = try? JSONDecoder().decode(
                        responseModel, from: data)
                else {
                    return .failure(.decode)
                }
                return .success(decodeResponse)
            case 401:
                return .failure(.unauthorized)
            case 403:
                return .failure(.forbidden)
            default:
                guard
                    let decodeResponse = try? JSONDecoder().decode(
                        responseModel, from: data)
                else {
                    return .failure(.decode)
                }
                return .success(decodeResponse)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}

final class DiverBookURLSessionDelegate: NSObject, URLSessionTaskDelegate {
    public func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        for transaction in metrics.transactionMetrics {
            print("✅ fetchType: \(transaction.resourceFetchType)")
        }
    }
}
