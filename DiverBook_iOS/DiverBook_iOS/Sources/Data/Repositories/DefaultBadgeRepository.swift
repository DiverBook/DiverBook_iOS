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

    func fetchBadges(collectedCount: Int) async throws -> [Badge] {
        let result = await badgeService.fetchBadges()

        switch result {
        case .success(let response):
            guard let badgeModels = response.data else {
                return []
            }
            return badgeModels.map { model in
                let requiredCount = mapCodeToRequiredCount(model.code)
                return model.toDomain(requiredCount: requiredCount, collectedCount: collectedCount)
            }
        case .failure(let error):
            throw error
        }
    }

    private func mapCodeToRequiredCount(_ code: String) -> Int {
        switch code {
        case "B001": return 1
        case "B002": return 10
        case "B003": return 20
        case "B004": return 30
        case "B005": return 40
        case "B006": return 50
        case "B007": return 99
        default: return Int.max
        }
    }
}
