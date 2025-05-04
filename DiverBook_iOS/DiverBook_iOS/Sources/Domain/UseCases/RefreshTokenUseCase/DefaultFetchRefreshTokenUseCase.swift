//
//  DefaultFetchRefreshTokenUseCase.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/3/25.
//

final class DefaultFetchRefreshTokenUseCase: FetchRefreshTokenUseCase {
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func exeute(refreshToken: String) async -> Result<AuthInfo, Error> {
        return await repository.refreshToken(refreshToken: refreshToken)
    }
}
