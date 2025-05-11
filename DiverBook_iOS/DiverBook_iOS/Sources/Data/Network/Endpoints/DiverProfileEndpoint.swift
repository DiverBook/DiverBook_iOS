//
//  DiverInfoEndpoint.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/30/25.
//

import Foundation

enum DiverProfileEndpoint: Endpoint {
    case profileImageUrl(nickName: String)
    case myProfile
    case diverProfile(id: String)
    case updateMyProfile(
        divisions: String,
        phoneNumber: String,
        interests: String,
        places: String,
        about: String
    )

    var path: String {
        switch self {
        case .profileImageUrl(let nickName):
            return "/api/users/profile-image/\(nickName)"
        case .myProfile:
            return "/api/users/me"
        case .diverProfile(let id):
            return "/api/users/\(id)"
        case .updateMyProfile:
            return "/api/users/me"
        }
    }

    var method: RequestMethod {
        switch self {
        case .profileImageUrl, .myProfile, .diverProfile:
            return .get
        case .updateMyProfile:
            return .patch
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
        case .profileImageUrl:
            return [
                "accept": "*/*",
                "Content-Type": "application/json"
            ]
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
        case .updateMyProfile(let params):
            return [
                "divisions": params.divisions,
                "phoneNumber": params.phoneNumber,
                "interests": params.interests,
                "places": params.places,
                "about": params.about,

            ]
        default:
            return nil
        }
    }
}
