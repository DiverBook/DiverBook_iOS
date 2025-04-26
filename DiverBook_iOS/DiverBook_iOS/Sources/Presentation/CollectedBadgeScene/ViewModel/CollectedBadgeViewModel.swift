//
//  CollectedBadgeViewModel.swift
//  DiverBook_iOS
//
//  Created by jun on 4/27/25.
//

import Foundation

struct BadgeState: Identifiable {
    let id = UUID()
    let name: String
    let displayImageName: String
    let isCollected: Bool
}

final class CollectedBadgeViewModel: ObservableObject {
    @Published var badges: [BadgeState] = []

    init(registeredDiverCount: Int) {
        loadBadges(for: registeredDiverCount)
    }

    private func loadBadges(for registeredDiverCount: Int) {
        let allBadges: [Badge] = [
            Badge(name: "첫 입수", requiredDiverCount: 1, imageName: "badge1"),
            Badge(name: "수면 돌파", requiredDiverCount: 10, imageName: "badge2"),
            Badge(name: "심해 탐험가", requiredDiverCount: 20, imageName: "badge3"),
            Badge(
                name: "숨 고르기 마스터",
                requiredDiverCount: 30,
                imageName: "badge4"
            ),
            Badge(name: "심해의 경계자", requiredDiverCount: 40, imageName: "badge5"),
            Badge(name: "베테랑 다이버", requiredDiverCount: 50, imageName: "badge6"),
            Badge(
                name: "레전드 다이버",
                requiredDiverCount: Int.max,
                imageName: "badge7"
            ),
        ]

        self.badges = allBadges.map { badge in
            let hasCollected = registeredDiverCount >= badge.requiredDiverCount
            return BadgeState(
                name: badge.name,
                displayImageName: hasCollected ? badge.imageName : "lock",
                isCollected: hasCollected
            )
        }
    }
}
