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
        var questions: [Question] = []
    }
    
    enum Action {
        case finishConversation(diverId: String)
        case selectCard(index: Int)
        case dismissCard
        case loadQuestions
    }
    
    @Published var selectedCardIndex: Int?
    @Published var isPopupCard: Bool = false
    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator
    
    private let fetchQuestionUseCase: FetchQuestionUseCase
    private let fetchRefreshTokenUseCase: FetchRefreshTokenUseCase
    
    init(
        coordinator: Coordinator,
        fetchQuestionUseCase: FetchQuestionUseCase,
        fetchRefreshTokenUseCase: FetchRefreshTokenUseCase
    ) {
        self.coordinator = coordinator
        self.fetchQuestionUseCase = fetchQuestionUseCase
        self.fetchRefreshTokenUseCase = fetchRefreshTokenUseCase
    }
    
    func action(_ action: Action) {
        switch action {
        case .finishConversation(let diverID):
            coordinator.push(.finishConversation(id: diverID))
        case .selectCard(let index):
            handleSelectCard(index: index)
        case .dismissCard:
            handleDismissCard()
        case .loadQuestions:
            loadQuestions()
        }
    }
    
    private func handleSelectCard(index: Int) {
        selectedCardIndex = index
        isPopupCard = true
    }
    
    private func handleDismissCard() {
        withAnimation {
            isPopupCard = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.selectedCardIndex = nil
        }
    }
    
    private func loadQuestions() {
        Task {
            async let questionResult = TokenRefreshHandler.withTokenRefresh(
                operation: { await self.fetchQuestionUseCase.executeFetchQuestion(count: 4) },
                refreshTokenUseCase: fetchRefreshTokenUseCase)
            
            let result = await questionResult
            
            switch result {
            case .success(let questions):
                state.questions = questions
            case .failure(let error):
                print("Failed to fetch questions: \(error)")
            }
        }
    }
}
