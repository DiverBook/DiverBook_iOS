//
//  DefaultFetchBadgesUseCase.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

final class DefaultFetchBadgesUseCase: FetchBadgesUseCase {
    private let badgeRepository: BadgeRepository

    init(badgeRepository: BadgeRepository) {
        self.badgeRepository = badgeRepository
    }

    func executeFetchBadges() async throws -> [Badge] {
        try await badgeRepository.fetchBadges()
    }
}
