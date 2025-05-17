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
        var rewardDesription: String = ""
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
                badgeService: CollectedBadgeService()
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
                let collectedCodes = try await fetchBadgesUseCase.executeFetchBadges()
                if collectedCodes.contains(badgeCode) {
                    if let badgeMeta = BadgeMeta.allBadges.first(where: { $0.code == badgeCode }) {
                        await MainActor.run {
                            state = State(
                                badgeImage: badgeMeta.code,
                                badgeName: badgeMeta.name,
                                rewardDesription: badgeMeta.rewardDescription
                            )
                        }
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
