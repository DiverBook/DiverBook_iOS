//
//  DefaultUserDeactivateRepository.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

final class DefaultUserDeactivateRepository: UserDeactivateRepository {
    private let userDeactivateService: UserDeactivateServicable

    init(userDeactivateService: UserDeactivateServicable) {
        self.userDeactivateService = userDeactivateService
    }

    func deactivateUser(refreshToken: String) async -> Result<DiverProfile, Error> {
        let result = await userDeactivateService.deactivateUser(refreshToken: refreshToken)
        switch result {
        case .success(let response):
            if let data = response.data {
                return .success(data.toDomain())
            } else {
                return .failure(RequestError.noResponse)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
