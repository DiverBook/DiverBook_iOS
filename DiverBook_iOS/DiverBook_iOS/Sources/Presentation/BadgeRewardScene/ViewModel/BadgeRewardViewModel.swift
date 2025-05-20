//
//  BadenRewardViewModel.swift
//  DiverBook_iOS
//
//  Created by jun on 5/7/25.
//

import Foundation
import SwiftUI

class BadgeRewardViewModel: ObservableObject {
    struct State {
        var isDataFetching: Bool = false
        var badgeImage: String = ""
        var badgeName: String = ""
        var rewardDesription: String = ""
    }

    enum Action {
        case viewAppeared
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
                badgeService: CollectedBadgeService()
            )
        )
    ) {
        self.coordinator = coordinator
        self.badgeCode = badgeCode
        self.fetchBadgesUseCase = fetchBadgesUseCase
    }

    func action(_ action: Action) {
        switch action {
        case .viewAppeared:
            Task {
                await MainActor.run {
                    state.isDataFetching = true
                }
                await loadBadge()
                await MainActor.run {
                    state.isDataFetching = false
                }
            }

        case .confirmButtonTapped:
            coordinator.path = [.mainTab]
        }
    }

    private func loadBadge() async {
        do {
            let collectedCodes = try await fetchBadgesUseCase.executeFetchBadges()
            if collectedCodes.contains(badgeCode),
               let badgeMeta = BadgeMeta.allBadges.first(where: { $0.code == badgeCode }) {
                await MainActor.run {
                    state.badgeImage = badgeMeta.code
                    state.badgeName = badgeMeta.name
                    state.rewardDesription = badgeMeta.rewardDescription
                }
            }
        } catch {
            print("❌ [BadgeReward] 뱃지 로딩 실패: \(error)")
        }
    }
}
