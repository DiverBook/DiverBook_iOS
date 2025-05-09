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
        var badge = "badge1"
        var badgeName = "첫 입수"
        var badgeDescription = "첫 다이버 등록"
    }

    enum Action {
        case confirmButtonTapped
    }

    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func action(_ action: Action) {
        switch action {
        case .confirmButtonTapped:
            coordinator.push(.collectedBadge)
        }
    }
}
