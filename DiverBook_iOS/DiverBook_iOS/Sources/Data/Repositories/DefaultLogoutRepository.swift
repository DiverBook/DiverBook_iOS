//
//  DefaultLogoutRepository.swift
//  DiverBook_iOS
//
//  Created by jun on 5/20/25.
//

import Foundation

final class DefaultLogoutRepository: LogoutRepository {
    private let logoutService: DiverBookLogoutServicable

    init(logoutService: DiverBookLogoutServicable) {
        self.logoutService = logoutService
    }

    func logout(refreshToken: String) async -> Result<AuthInfo, Error> {
        let logoutResult = await logoutService.logout(
            refreshToken: refreshToken
        )
        switch logoutResult {
        case .success(let baseResponse):
            if baseResponse.success, let data = baseResponse.data {
                return .success(data.toDomain())
            } else {
                return .failure(
                    RequestError.errorWithLog(baseResponse.errorMessage ?? "")
                )
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
