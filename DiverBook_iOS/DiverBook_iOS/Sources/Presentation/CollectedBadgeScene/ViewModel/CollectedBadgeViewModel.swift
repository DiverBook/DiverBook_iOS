//
//  CollectedBadgeViewModel.swift
//  DiverBook_iOS
//
//  Created by jun on 4/27/25.
//

import Foundation
import SwiftUI

class CollectedBadgeViewModel: ViewModelable {
    struct State {
        var badges: [BadgeMeta] = []
    }

    enum Action {
        case fetchBadges
    }

    @Published var state = State()

    private let fetchBadgesUseCase: FetchBadgesUseCase

    init(fetchBadgesUseCase: FetchBadgesUseCase) {
        self.fetchBadgesUseCase = fetchBadgesUseCase
        action(.fetchBadges)
    }

    func action(_ action: Action) {
        switch action {
        case .fetchBadges:
            loadAllBadges()
        }
    }

    private func loadAllBadges() {
        Task {
            do {
                let collectedBadgeCodes = try await fetchBadgesUseCase.executeFetchBadges()
                let collectedSet = Set(collectedBadgeCodes)

                let updatedBadges: [BadgeMeta] = BadgeMeta.allBadges.map { badge in
                    BadgeMeta(
                        code: badge.code,
                        name: badge.name,
                        rewardDescription: badge.rewardDescription,
                        description: badge.description,
                        condition: badge.condition,
                        imageName: badge.imageName,
                        isCollected: collectedSet.contains(badge.code) // ✅ 상태 업데이트 핵심
                    )
                }

                await MainActor.run {
                    self.state.badges = updatedBadges
                }

            } catch {
                print("❌ Failed to load collected badges: \(error)")
            }
        }
    }
}
