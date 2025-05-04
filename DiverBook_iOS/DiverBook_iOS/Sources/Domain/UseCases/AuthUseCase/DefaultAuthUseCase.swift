//
//  DefaultAuthUseCase.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/28/25.
//

final class DefaultAuthUseCase: AuthUseCase {
    private var authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func executeSignUp(
        userName: String,
        divisions: String,
        phoneNumber: String,
        interests: String,
        places: String,
        about: String,
        password: String
    ) async -> Result<Bool, Error> {
        return await authRepository.signUp(
            userName: userName,
            divisions: divisions,
            phoneNumber: phoneNumber,
            interests: interests,
            places: places,
            about: about,
            password: password
        )
    }
}
