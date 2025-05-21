//
//  DefaultBadgeRepository.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

final class DefaultBadgeRepository: BadgeRepository {
    private let badgeService: BadgeServicable

    init(badgeService: BadgeServicable) {
        self.badgeService = badgeService
    }

    func fetchUserBadges() async throws -> [String] {
        let result = await badgeService.fetchUserBadges()

        switch result {
        case .success(let response):
            return (response.data ?? []).compactMap { $0.badgeCode }
        case .failure(let error):
            throw error
        }
    }

    func postUserBadge(badgeCode: String) async throws -> CollectedBadge {
        let result = await badgeService.postUserBadge(badgeCode: badgeCode)

        switch result {
        case .success(let response):
            guard let dto = response.data else {
                throw RequestError.decode
            }
            return dto.toDomain()

        case .failure(let error):
            throw error
        }
    }
}
