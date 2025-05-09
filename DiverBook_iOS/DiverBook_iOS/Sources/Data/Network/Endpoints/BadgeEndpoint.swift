//
//  BadgeEndpoint.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

enum BadgeEndpoint: Endpoint {
    case getBadges
    case getUserBadges
}

extension BadgeEndpoint {
    var path: String {
        switch self {
        case .getBadges:
            return "/api/badges"
        case .getUserBadges:
            return "/api/user-badge"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getBadges:
            return .get
        case .getUserBadges:
            return .get
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
