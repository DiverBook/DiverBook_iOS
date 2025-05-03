//
//  DiverBookTokenEndpoint.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/3/25.
//

import Foundation

enum DiverBookTokenEndpoint: Endpoint {
    case refreshToken(refreshToken: String)
    
    var path: String {
        switch self {
        case .refreshToken:
            return "/api/auth/refresh"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .refreshToken:
            return .post
        }
    }
    
    var query: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .refreshToken:
            return [
                "accept": "*/*",
                "Content-Type": "application/json"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .refreshToken(let refreshToken):
            return ["refreshToken": refreshToken]
        }
    }
}
