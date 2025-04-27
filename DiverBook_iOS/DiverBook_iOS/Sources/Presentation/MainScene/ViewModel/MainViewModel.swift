//
//  MainViewModel.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/7/25.
//

import Combine
import SwiftUI

final class MainViewModel: ViewModelable {
    struct State {
        var userNickname: String = "Ted"
        var bookAttainmentRate: Double = 50
    }
    
    enum Action {
        case profileSettingButtonTapped
        case diverTapped
    }
    
    @Published var state: State = State()
    
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .profileSettingButtonTapped:
            print("profile setting button tapped!")
        case .diverTapped:
            print("diver tapped!")
        }
    }
}
