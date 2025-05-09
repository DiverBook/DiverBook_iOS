//
//  UserDeactivateEndpoint.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

enum UserDeactivateEndpoint: Endpoint {
    case deactivate

    var path: String {
        switch self {
        case .deactivate:
            return "/api/users/me/deactivate"
        }
    }

    var method: RequestMethod {
        return .post
    }

    var query: [String: String]? {
        return nil
    }

    var header: [String: String]? {
        switch self {
        default:
            return [
                "accept": "*/*",
                "Content-Type": "application/json",
                "Authorization":
                    "\(UserToken.tokenType) \(UserToken.accessToken)",
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
