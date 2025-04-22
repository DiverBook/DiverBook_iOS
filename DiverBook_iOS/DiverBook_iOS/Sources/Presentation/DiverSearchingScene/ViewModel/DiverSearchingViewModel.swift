//
//  DiverSearchingViewModel.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/20/25.
//

import Combine
import SwiftUI

final class DiverSearchingViewModel: ViewModelable {
    struct State {
    }
    
    enum Action {
        case successSearchingDiver(nickname: String)
    }
    
    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .successSearchingDiver(let nickname):
            self.coordinator.push(.searchResult(nickname: nickname))
        }
    }
}
