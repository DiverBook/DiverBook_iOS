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
    }
    
    enum Action {
        case splashEnd
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
            self.state.isSplashing = false
        case .signUpButtonTapped:
            self.coordinator.push(.idCardScan)
        }
    }
}
