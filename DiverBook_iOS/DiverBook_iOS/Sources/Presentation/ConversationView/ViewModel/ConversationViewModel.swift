//
//  ConversationViewModel.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/23/25.
//

import Combine
import SwiftUI

final class ConversationViewModel: ViewModelable {
    struct State {
        
    }
    
    enum Action {
        case finishConversation
    }
    
    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .finishConversation:
            coordinator.push(.finishConversation)
        }
    }
}
