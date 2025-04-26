//
//  ConversationViewModel.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/23/25.
//

import Combine
import SwiftUI

final class ConversationViewModel: ViewModelable {
    @Published var selectedCardIndex: Int?
    @Published var isPopupCard: Bool = false
    
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
    
    func selectCard(index: Int) {
        selectedCardIndex = index
        isPopupCard = true
    }
    
    func dismissCard() {
        withAnimation {
            isPopupCard = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.selectedCardIndex = nil
        }
    }
}
