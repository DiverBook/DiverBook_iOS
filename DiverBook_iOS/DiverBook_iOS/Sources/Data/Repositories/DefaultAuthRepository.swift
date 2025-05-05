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
        case .success(let baseResponse):
            if baseResponse.success, let data = baseResponse.data {
                let authInfo = data.toDomain()
                UserToken.updateTokens(authInfo: authInfo)
                return .success(true)
            }
            else {
                return .success(false)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func refreshToken(
        refreshToken: String
    ) async -> Result<AuthInfo, Error> {
        let refreshResult = await authService.request(
            endpoint: DiverBookTokenEndpoint.refreshToken(refreshToken: refreshToken),
            responseModel: BaseResponse<RefreshTokenResModel>.self
        )
        
        switch refreshResult {
        case .success(let baseResponse):
            if baseResponse.success, let data = baseResponse.data {
                let authInfo = data.toDomain()
                tokenService.saveTokens(authInfo: authInfo)
                return .success(authInfo)
            } else {
                let errorMessage = baseResponse.errorMessage ?? "Error"
                return .failure(RequestError.unauthorized)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
