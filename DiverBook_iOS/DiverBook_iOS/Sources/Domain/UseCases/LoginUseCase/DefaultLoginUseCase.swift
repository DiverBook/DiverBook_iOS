//
//  DefaultLoginUseCase.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/4/25.
//

final class DefaultLoginUseCase: LoginUseCase {
    private var loginRepository: LoginRepository
    
    init(loginRepository: LoginRepository) {
        self.loginRepository = loginRepository
    }
    
    func executeLogin(userName: String, password: String) async -> Result<AuthInfo, Error> {
        let loginResult = await loginRepository.login(userName: userName, password: password)
        switch loginResult {
        case .success(let authInfo):
            UserToken.updateTokens(authInfo: authInfo)
            return .success(authInfo)
        case .failure(let error):
            return .failure(error)
        }
    }
}
