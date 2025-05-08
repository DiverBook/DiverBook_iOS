//
//  DeactivateUserUseCase.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

protocol DeactivateUserUseCase {
    func execute() async -> Result<DiverProfile, Error>
}

final class DefaultDeactivateUserUseCase: DeactivateUserUseCase {
    private let repository: UserDeactivateRepository

    init(repository: UserDeactivateRepository) {
        self.repository = repository
    }

    func execute() async -> Result<DiverProfile, Error> {
        return await repository.deactivateUser()
    }
}
