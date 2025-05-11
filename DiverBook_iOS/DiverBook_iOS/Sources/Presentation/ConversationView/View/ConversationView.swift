//
//  ConversationView.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/23/25.
//

import SwiftUI

struct ConversationView: View {
    @Namespace private var animationNamespace
    @StateObject var viewModel: ConversationViewModel
    
    let diverId: String
    
    init(coordinator: Coordinator, diverId: String) {
        _viewModel = StateObject(
            wrappedValue: ConversationViewModel(
                coordinator: coordinator,
                fetchQuestionUseCase: DefaultFetchQuestionUseCase(
                    repository: DefaultQuestionRepository(questionService: QuestionService())
                ), fetchRefreshTokenUseCase: DefaultFetchRefreshTokenUseCase(
                    repository: DefaultAuthRepository(
                        authService: DiverBookAuthService(),
                        tokenService: DiverBookTokenService()
                    )
                )
            )
        )
        self.diverId = diverId
    }
    
    var body: some View {
        ZStack {
            QuestionCardGridView(
                viewModel: viewModel,
                animationNamespace: animationNamespace,
                diverId: diverId
            )
            
            popupCardView()
        }
        .onAppear {
            viewModel.action(.loadQuestions)
        }
    }
    
    @ViewBuilder
    private func popupCardView() -> some View {
        if let cardIndex = viewModel.selectedCardIndex,
           viewModel.isPopupCard {
            Color.black.opacity(0.2)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        viewModel.action(.dismissCard)
                    }
                }
                .zIndex(1)

            FlipCardView(
                cardIndex: cardIndex,
                animationNamespace: animationNamespace,
                question: viewModel.state.questions[cardIndex]
            )
                .transition(.scale.animation(.easeIn))
                .zIndex(2)
        }
    }
}
