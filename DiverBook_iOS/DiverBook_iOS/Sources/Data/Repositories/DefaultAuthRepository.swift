//
//  DefaultAuthRepository.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/28/25.
//

final class DefaultAuthRepository: AuthRepository {
    private var authService: DiverBookAuthServicable
    private var tokenService: DiverBookTokenServicable
    
    init(
        authService: DiverBookAuthServicable,
        tokenService: DiverBookTokenServicable
    ) {
        self.authService = authService
        self.tokenService = tokenService
    }
    
    func signUp(
        userName: String,
        divisions: String,
        phoneNumber: String,
        interests: String,
        places: String,
        about: String,
        password: String
    ) async -> Result<Bool, Error> {
        let signUpResult = await authService.signUp(
            userName: userName,
            divisions: divisions,
            phoneNumber: phoneNumber,
            interests: interests,
            places: places,
            about: about,
            password: password
        )
        
        switch signUpResult {
        case .success(let signUpResModel):
            let authInfo = signUpResModel.toDomain()
            tokenService.saveTokens(authInfo: authInfo)
            return .success(true)
        case .failure(let error):
            return .failure(error)
        }
    }
}
