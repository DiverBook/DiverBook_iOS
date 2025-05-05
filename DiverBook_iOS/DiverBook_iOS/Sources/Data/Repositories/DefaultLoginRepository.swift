//
//  DefaultLoginRepository.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/4/25.
//

final class DefaultLoginRepository: LoginRepository {
    private let loginService: DiverBookLoginServicable
    
    init(loginService: DiverBookLoginServicable) {
        self.loginService = loginService
    }
    
    func login(userName: String, password: String) async -> Result<AuthInfo, Error> {
        let loginResult = await loginService.login(userName: userName, password: password)
        switch loginResult {
        case .success(let baseResponse):
            if baseResponse.success, let data = baseResponse.data {
                return .success(data.toDomain())
            }
            else {
                return .failure(RequestError.errorWithLog(baseResponse.errorMessage ?? ""))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
