//
//  DiverBookAuthEndpoint.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/28/25.
//

import Foundation

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
    case checkActivation(
        userName: String
    )
    case login(
        userName: String,
        password: String
    )
    
    var path: String {
        switch self {
        case .signUp:
            return "/api/auth/signup"
        case .checkActivation(let userName):
            return "/api/users/activation/\(userName)"
        case .login:
            return "/api/auth/login"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .signUp, .login:
            return .post
        case .checkActivation:
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
        case .signUp, .checkActivation, .login:
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
        case .login(let params):
            return [
                "userName": params.userName,
                "password": params.password
            ]
        default:
            return nil
        }
    }
}
