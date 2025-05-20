//
//  DeactivateUserUseCase.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

protocol DeactivateUserUseCase {
    func execute(refreshToken: String) async -> Result<DiverProfile, Error>
}

final class DefaultDeactivateUserUseCase: DeactivateUserUseCase {
    private let repository: UserDeactivateRepository

    init(repository: UserDeactivateRepository) {
        self.repository = repository
    }

    func execute(refreshToken: String) async -> Result<DiverProfile, Error> {
        let deactivateResult = await repository.deactivateUser(refreshToken: refreshToken)
        switch deactivateResult {
        case .success(let authInfo):
            UserToken.clear()
            return .success(authInfo)
        case .failure(let error):
            return .failure(error)
        }
    }
}
