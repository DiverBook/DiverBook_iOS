//
//  UpdateMyProfileUseCase.swift
//  DiverBook_iOS
//
//  Created by jun on 5/10/25.
//

import Foundation

protocol UpdateMyProfileUseCase {
    func execute(
        divisions: String,
        phoneNumber: String,
        interests: String,
        places: String,
        about: String
    ) async -> Result<DiverProfile, Error>
}
