//
//  SignUpResModel.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/28/25.
//

struct SignUpResModel: Decodable {
    var id: String
    var accessToken: String
    var refreshToken: String
    var tokenType: String
}

// MARK: - Mappings to Domain
extension SignUpResModel {
    func toDomain() -> AuthInfo {
        return .init(
            id: id,
            accessToken: accessToken,
            refreshToken: refreshToken,
            tokenType: tokenType)
    }
}
