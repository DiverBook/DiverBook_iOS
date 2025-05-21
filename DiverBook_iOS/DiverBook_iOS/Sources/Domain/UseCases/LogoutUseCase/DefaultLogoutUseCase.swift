//
//  DefaultLogoutUseCase.swift
//  DiverBook_iOS
//
//  Created by jun on 5/20/25.
//

import Foundation

final class DefaultLogoutUseCase: LogoutUseCase {
    private let logoutRepository: LogoutRepository

    init(logoutRepository: LogoutRepository) {
        self.logoutRepository = logoutRepository
    }

    func executeLogout(refreshToken: String) async -> Result<AuthInfo, Error> {
        let logoutResult = await logoutRepository.logout(refreshToken: refreshToken)
        switch logoutResult {
        case .success(let authInfo):
            UserToken.clear()
            return .success(authInfo)
        case .failure(let error):
            return .failure(error)
        }
    }
}
