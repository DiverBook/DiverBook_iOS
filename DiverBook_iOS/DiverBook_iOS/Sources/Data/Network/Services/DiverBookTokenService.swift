//
//  DiverBookTokenService.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/28/25.
//

final class DiverBookTokenService: DiverBookTokenServicable {
    func saveTokens(authInfo: AuthInfo) {
        UserToken.accessToken = authInfo.accessToken
        UserToken.refreshToken = authInfo.refreshToken
        UserToken.tokenType = authInfo.tokenType
        UserToken.id = authInfo.id
    }
}
