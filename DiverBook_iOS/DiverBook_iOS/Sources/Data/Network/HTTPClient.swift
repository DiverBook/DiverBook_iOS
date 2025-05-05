//
//  HTTPClient.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/28/25.
//
import Foundation

protocol HTTPClient {
    func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async
        -> Result<T, RequestError>
}

extension HTTPClient {
    func request<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
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
            let (data, response) = try await URLSession.shared.data(
                for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.decode)
            }

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
