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
        var badges: [Badge] = []
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

                let allBadges: [Badge] = BadgeMeta.allBadges.map { meta in
                    Badge(
                        code: meta.code,
                        name: meta.name,
                        description: meta.description,
                        imageName: meta.imageName,
                        isCollected: collectedSet.contains(meta.code)
                    )
                }

                await MainActor.run {
                    self.state.badges = allBadges
                }

            } catch {
                print("❌ Failed to load all badges: \(error)")
            }
        }
    }
}
