//
//  RequestError.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/28/25.
//

enum RequestError: Error, Equatable {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case forbidden
    case unexpectedStatusCode
    case errorWithLog(String)
    case unknown

    var message: String {
        switch self {
        case .decode:
            return "Decode"
        case .invalidURL:
            return "Session expired"
        case .noResponse:
            return "noResponse"
        case .unauthorized:
            return "unauthorized"
        case .forbidden:
            return "forbidden"
        case .unexpectedStatusCode:
            return "unexpected"
        case .errorWithLog(let errorLog):
            return errorLog
        case .unknown:
            return "unknown"
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .decode:
            return "Decode"
        case .invalidURL:
            return "Session expired"
        case .noResponse:
            return "noResponse"
        case .unauthorized:
            return "unauthorized"
        case .unexpectedStatusCode:
            return "unexpected"
        case .errorWithLog(let errorLog):
            return errorLog
        case .unknown:
            return "unknown"
        }
    }
}
