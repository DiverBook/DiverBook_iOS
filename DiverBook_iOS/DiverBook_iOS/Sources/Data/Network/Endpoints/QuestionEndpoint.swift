//
//  QuestionEndpoint.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/6/25.
//

import Foundation

enum QuestionEndpoint: Endpoint {
    case fetchQuestions(
        count: Int
    )
    
    var path: String {
        switch self {
        case .fetchQuestions(let count):
            return "/api/questions/\(count)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .fetchQuestions:
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
        case .fetchQuestions:
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
