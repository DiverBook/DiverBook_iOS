//
//  DefaultPostUserBadgeUseCase.swift
//  DiverBook_iOS
//
//  Created by jun on 5/12/25.
//

import Foundation

final class DefaultPostUserBadgeUseCase: PostUserBadgeUseCase {
    
    private let badgeRepository: BadgeRepository

    init(badgeRepository: BadgeRepository) {
        self.badgeRepository = badgeRepository
    }

    func executePostUserBadge(badgeCode: String) async throws -> String {
        return try await badgeRepository.postUserBadge(badgeCode: badgeCode)
    }
}
