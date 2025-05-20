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

    func logout(refreshToken: String) async throws -> Result<AuthInfo, Error> {
        let result = await logoutService.logout(refreshToken: refreshToken)
        switch result {
        case .success(let response):
            if let data = response.data {
                return .success(data.toDomain())
            } else {
                return .failure(RequestError.errorWithLog(response.errorMessage ?? ""))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
