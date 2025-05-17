//
//  BadgeEndpoint.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

enum BadgeEndpoint: Endpoint {
    case getUserBadges
    case postUserBadge(badgeCode: String)
}

extension BadgeEndpoint {
    var path: String {
        switch self {
        case .getUserBadges:
            return "/api/user-badge"
        case .postUserBadge(let badgeCode):
            return "/api/user-badge/\(badgeCode)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getUserBadges:
            return .get
        case .postUserBadge:
            return .post
        }
    }

    var query: [String: String]? {
        return nil
    }

    var header: [String: String]? {
        return [
            "accept": "*/*",
            "Content-Type": "application/json",
            "Authorization": "\(UserToken.tokenType) \(UserToken.accessToken)",
        ]
    }

    var body: [String: String]? {
        return nil
    }
}
