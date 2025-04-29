//
//  DiverBookAuthEndpoint.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/28/25.
//

enum DiverBookAuthEndpoint: Endpoint {
    case signUp(
        userName: String,
        divisions: String,
        phoneNumber: String,
        interests: String,
        places: String,
        about: String,
        password: String
    )
    
    var path: String {
        switch self {
        case .signUp:
            return "/api/auth/signup"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .signUp:
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
        case .signUp:
            return [
                "accept": "*/*",
                "Content-Type": "application/json"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .signUp(let params):
            return [
                "userName": params.userName,
                "divisions": params.divisions,
                "phoneNumber": params.phoneNumber,
                "interests": params.interests,
                "places": params.places,
                "about": params.about,
                "password": params.password
            ]
        }
    }
}
