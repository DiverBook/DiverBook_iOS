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
    let description: String
}

final class CollectedBadgeViewModel: ObservableObject {
    struct State {
        var badges: [BadgeState] = []
    }

    enum Action {
        case fetchBadges(registeredDiverCount: Int)
    }

    @Published var state = State()

    init(registeredDiverCount: Int) {
        action(.fetchBadges(registeredDiverCount: registeredDiverCount))
    }

    func action(_ action: Action) {
        switch action {
        case .fetchBadges(let registeredDiverCount):
            loadBadges(for: registeredDiverCount)
        }
    }

    private func loadBadges(for registeredDiverCount: Int) {
        let allBadges: [Badge] = [
            Badge(
                name: "첫 입수",
                requiredDiverCount: 1,
                imageName: "badge1",
                description: "첫 다이버를 등록했어요. \n당신의 탐험을 응원합니다!"
            ),
            Badge(
                name: "수면 돌파",
                requiredDiverCount: 10,
                imageName: "badge2",
                description: "벌써 10명의 다이버를 만났어요. \n수면 위의 세상이 눈 앞에!"
            ),
            Badge(
                name: "심해 탐험가",
                requiredDiverCount: 20,
                imageName: "badge3",
                description: "깊고 어두운 심해 속, \n새로운 다이버를 찾아서 쑥~"
            ),
            Badge(
                name: "숨 고르기 마스터",
                requiredDiverCount: 30,
                imageName: "badge4",
                description: "잠깐 숨 돌려요. \n여긴 중간 체크 포인트예요!"
            ),
            Badge(
                name: "다이버 콜렉터",
                requiredDiverCount: 30,
                imageName: "badge5",
                description: "다양한 다이버들을 불러모았어요. \n다이버들은 많을수록 좋아요!"
            ),
            Badge(
                name: "심해의 경계자",
                requiredDiverCount: 40,
                imageName: "badge6",
                description: "드디어 위험한(?) 다이버들도 \n만나기 시작했군요...!"
            ),
            Badge(
                name: "베테랑 다이버",
                requiredDiverCount: 50,
                imageName: "badge7",
                description: "산소가 부족해도 여유로운 당신, \n이제 진짜 프로예요."
            ),
            Badge(
                name: "레전드 다이버",
                requiredDiverCount: Int.max,
                imageName: "badge8",
                description: "전설의 다이버, \n모든 다이버를 빛내는 당신을 존경합니다 👍"
            ),
        ]

        self.state.badges = allBadges.map { badge in
            let hasCollected = registeredDiverCount >= badge.requiredDiverCount
            return BadgeState(
                name: badge.name,
                displayImageName: hasCollected ? badge.imageName : "lock",
                isCollected: hasCollected,
                description: badge.description
            )
        }
    }
}
