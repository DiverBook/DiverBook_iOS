//
//  DiverInfoEndpoint.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/30/25.
//

import Foundation

enum DiverProfileEndpoint: Endpoint {
    case diverProfile(id: String)
    
    var path: String {
        switch self {
        case .diverProfile(let id):
            return "/api/users/\(id)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        default:
            return .get
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
        default:
            return [
                "accept": "*/*",
                "Content-Type": "application/json",
                "Authorization": "\(UserToken.tokenType) \(UserToken.accessToken)"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
}
