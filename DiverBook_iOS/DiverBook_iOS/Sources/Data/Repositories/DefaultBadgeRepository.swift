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

    func fetchBadges() async throws -> [Badge] {
        async let allBadgesResult = badgeService.fetchBadges()
        async let userBadgesResult = badgeService.fetchUserBadges()

        let allBadges = try await allBadgesResult.get().data ?? []
        let userBadgeCodes = try await userBadgesResult.get().data?.map(\.badgeCode) ?? []

        return allBadges.map {
            $0.toDomain(isCollected: userBadgeCodes.contains($0.code))
        }
    }
}
