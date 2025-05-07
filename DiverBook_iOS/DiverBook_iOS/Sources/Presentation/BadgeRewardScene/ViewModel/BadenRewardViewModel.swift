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
        var badge = ""
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
