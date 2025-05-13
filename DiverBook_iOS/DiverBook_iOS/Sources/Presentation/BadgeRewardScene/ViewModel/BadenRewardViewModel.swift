//
//  BadenRewardViewModel.swift
//  DiverBook_iOS
//
//  Created by jun on 5/7/25.
//

import Foundation
import SwiftUI

class BadenRewardViewModel: ObservableObject {
    struct State {
        var badgeImage: String = ""
        var badgeName: String = ""
    }

    enum Action {
        case confirmButtonTapped
    }

    @Published var state = State()
    @ObservedObject var coordinator: Coordinator

    private let badgeCode: String
    private let fetchBadgesUseCase: FetchBadgesUseCase

    init(
        coordinator: Coordinator,
        badgeCode: String,
        fetchBadgesUseCase: FetchBadgesUseCase = DefaultFetchBadgesUseCase(
            badgeRepository: DefaultBadgeRepository(
                badgeService: BadgeService()
            )
        )
    ) {
        self.coordinator = coordinator
        self.badgeCode = badgeCode
        self.fetchBadgesUseCase = fetchBadgesUseCase
    }

    func loadBadge() {
        Task {
            do {
                let badges = try await fetchBadgesUseCase.executeFetchBadges()
                if let matched = badges.first(where: { $0.code == badgeCode }) {
                    await MainActor.run {
                        state = State(
                            badgeImage: matched.imageUrl,
                            badgeName: matched.name
                        )
                    }
                }
            } catch {
                print("❌ 뱃지 로딩 실패: \(error)")
            }
        }
    }

    func action(_ action: Action) {
        switch action {
        case .confirmButtonTapped:
            coordinator.path = [.mainTab]
        }
    }
}
