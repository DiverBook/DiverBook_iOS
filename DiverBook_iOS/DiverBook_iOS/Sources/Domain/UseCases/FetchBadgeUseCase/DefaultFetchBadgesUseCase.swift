//
//  DefaultFetchBadgesUseCase.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

final class DefaultFetchBadgesUseCase: FetchBadgesUseCase {
    private let repository: BadgeRepository

    init(repository: BadgeRepository) {
        self.repository = repository
    }

    func execute(collectedCount: Int) async throws -> [Badge] {
        return try await repository.fetchBadges(collectedCount: collectedCount)
    }
}
