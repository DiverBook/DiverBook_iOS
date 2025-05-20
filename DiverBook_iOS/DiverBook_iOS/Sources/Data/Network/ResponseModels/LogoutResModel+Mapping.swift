//
//  LogoutResModel+Mapping.swift
//  DiverBook_iOS
//
//  Created by jun on 5/20/25.
//

import Foundation

struct LogoutResModel: Decodable {
    var id: String
    var accessToken: String?
    var refreshToken: String?
    var tokenType: String
}

// MARK: - Mappings to Domain
extension LogoutResModel {
    func toDomain() -> AuthInfo {
        return .init(
            id: id,
            accessToken: accessToken ?? "",
            refreshToken: refreshToken ?? "",
            tokenType: tokenType)
    }
}

