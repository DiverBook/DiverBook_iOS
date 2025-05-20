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
        return await logoutRepository.logout(refreshToken: refreshToken)
    }
}
