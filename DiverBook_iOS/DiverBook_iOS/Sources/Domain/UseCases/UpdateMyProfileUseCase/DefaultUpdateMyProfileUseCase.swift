//
//  DefaultUpdateMyProfileUseCase.swift
//  DiverBook_iOS
//
//  Created by jun on 5/10/25.
//

import Foundation

final class DefaultUpdateMyProfileUseCase: UpdateMyProfileUseCase {
    private let repository: DiverRepository

    init(repository: DiverRepository) {
        self.repository = repository
    }

    func execute(
        divisions: String,
        phoneNumber: String,
        interests: String,
        places: String,
        about: String
    ) async -> Result<DiverProfile, Error> {
        return await repository.updateMyProfile(
            divisions: divisions,
            phoneNumber: phoneNumber,
            interests: interests,
            places: places,
            about: about
        )
    }
}
