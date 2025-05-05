//
//  TokenRefreshHandler.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/3/25.
//

import Foundation

struct TokenRefreshHandler {
    static func withTokenRefresh<T>(
        operation: @escaping () async -> Result<T, Error>,
        refreshTokenUseCase: FetchRefreshTokenUseCase
    ) async -> Result<T, Error> {
        let result = await operation()

        if case .failure(let error) = result,
           let requestError = error as? RequestError,
           requestError == .forbidden {
            let refreshToken = UserToken.refreshToken
            let refreshResult = await refreshTokenUseCase.exeute(refreshToken: refreshToken)

            switch refreshResult {
            case .success(let newAuthInfo):
                UserToken.updateTokens(authInfo: newAuthInfo)
                return await operation()
            case .failure(let refreshError):
                return .failure(refreshError)
            }
        }
        return result
    }
}
