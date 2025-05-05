//
//  LoginResModel+Mapping.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/4/25.
//

struct LoginResModel: Decodable {
    var id: String
    var accessToken: String
    var refreshToken: String
    var tokenType: String
}

// MARK: - Mappings to Domain
extension LoginResModel {
    func toDomain() -> AuthInfo {
        return .init(
            id: id,
            accessToken: accessToken,
            refreshToken: refreshToken,
            tokenType: tokenType)
    }
}
