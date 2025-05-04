//
//  FetchRefreshTokenUseCase.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/3/25.
//

protocol FetchRefreshTokenUseCase {
    func exeute(refreshToken: String) async -> Result<AuthInfo, Error>
}
