//
//  UserToken.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/28/25.
//

struct UserToken {
    @UserDefault(key: "accessToken", defaultValue: "")
    static var accessToken: String
    
    @UserDefault(key: "refreshToken", defaultValue: "")
    static var refreshToken: String
    
    @UserDefault(key: "tokenType", defaultValue: "")
    static var tokenType: String
    
    @UserDefault(key: "id", defaultValue: "")
    static var id: String
}

// MARK: RefreshToken을 위한 update 메서드
extension UserToken {
    static func updateTokens(authInfo: AuthInfo) {
        self.accessToken = authInfo.accessToken
        self.refreshToken = authInfo.refreshToken
        self.tokenType = authInfo.tokenType
        self.id = authInfo.id
    }
}
