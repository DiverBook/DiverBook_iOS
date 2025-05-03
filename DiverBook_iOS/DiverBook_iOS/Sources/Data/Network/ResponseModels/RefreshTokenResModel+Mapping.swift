//
//  RefreshTokenResModel+Mapping.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/2/25.
//

struct RefreshTokenResModel: Decodable {
    var id: String
    var accessToken: String
    var refreshToken: String
    var tokenType: String
}

// MARK: - Mappings to Domain
extension RefreshTokenResModel {
    func toDomain() -> AuthInfo {
        return .init(
            id: id,
            accessToken: accessToken,
            refreshToken: refreshToken,
            tokenType: tokenType)
    }
}
