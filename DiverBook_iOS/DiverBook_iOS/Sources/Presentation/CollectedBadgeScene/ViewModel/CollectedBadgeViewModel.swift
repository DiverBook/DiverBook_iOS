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
        case fetchBadges(registeredDiverCount: Int)
    }

    @Published var state = State()

    private let fetchBadgesUseCase: FetchBadgesUseCase

    init(registeredDiverCount: Int, fetchBadgesUseCase: FetchBadgesUseCase) {
        self.fetchBadgesUseCase = fetchBadgesUseCase
        action(.fetchBadges(registeredDiverCount: registeredDiverCount))
    }

    func action(_ action: Action) {
        switch action {
        case .fetchBadges(let registeredDiverCount):
            loadBadges(for: registeredDiverCount)
        }
    }

    private func loadBadges(for count: Int) {
        Task {
            do {
                let badges = try await fetchBadgesUseCase.execute(collectedCount: count)
                await MainActor.run {
                    self.state.badges = badges
                }
            } catch {
                print("❌ Failed to load badges: \(error)")
            }
        }
    }
}
