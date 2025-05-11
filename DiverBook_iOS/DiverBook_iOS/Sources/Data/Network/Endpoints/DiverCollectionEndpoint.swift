//
//  DiverCollectionEndpoint.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/6/25.
//

enum DiverCollectionEndpoint: Endpoint {

    case diverCollection
    case diverCollectionRate(id: String)
    case allDiverList
    case updateDiverMemo(foundUserId: String, memo: String)

    var path: String {
        switch self {
        case .diverCollection:
            return "/api/collections"
        case .diverCollectionRate(let id):
            return "/api/users/\(id)/achievement-rate"
        case .allDiverList:
            return "/api/users"
        case .updateDiverMemo:
            return "/api/collections"
        }
    }

    var method: RequestMethod {
        switch self {
        case .updateDiverMemo:
            return .post
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
                "Authorization":
                    "\(UserToken.tokenType) \(UserToken.accessToken)",
            ]
        }
    }

    var body: [String: String]? {
        switch self {
        case .updateDiverMemo(let foundUserId, let memo):
            return [
                "foundUserId": foundUserId,
                "memo": memo,
            ]
        default:
            return nil
        }
    }

}
