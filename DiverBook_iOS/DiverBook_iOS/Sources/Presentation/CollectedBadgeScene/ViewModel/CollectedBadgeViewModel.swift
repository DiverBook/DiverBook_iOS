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
            loadBadges()
        }
    }

    private func loadBadges() {
        Task {
            do {
                let badges = try await fetchBadgesUseCase.execute()
                await MainActor.run {
                    self.state.badges = badges
                }
            } catch {
                print("❌ Failed to load badges: \(error)")
            }
        }
    }
}
