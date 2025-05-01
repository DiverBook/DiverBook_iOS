//
//  OnboardingViewModel.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/14/25.
//

import Combine
import SwiftUI

class OnboardingViewModel: ViewModelable {
    struct State {
        var isSplashing: Bool = true
        var initialOnboardingEnd: Bool = AppSettings.hasLaunched
    }
    
    enum Action {
        case splashEnd
        case initialStartButtonTapped
        case signUpButtonTapped
    }
    
    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .splashEnd:
            state.isSplashing = false
        case .initialStartButtonTapped:
            AppSettings.hasLaunched = true
            state.initialOnboardingEnd = true
        case .signUpButtonTapped:
            coordinator.push(.idCardScan)
        }
    }
}
