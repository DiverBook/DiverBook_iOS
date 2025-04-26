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
    
    init(coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: ConversationViewModel(coordinator: coordinator))
    }
    
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 2)
    
    var body: some View {
        ZStack {
            VStack {
                TopBar()
                Spacer()
                Text("아래 카드를 고르면\n다이버와 깊이 잠수해볼 수 있어요")
                    .font(DiveFont.headingH3)
                    .foregroundColor(DiveColor.gray4)
                    .padding(.bottom, 25)
                    .multilineTextAlignment(.center)
                
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(0..<4) { index in
                        if viewModel.selectedCardIndex == index {
                            Color.clear
                        } else {
                            QuestionCardCell()
                                .matchedGeometryEffect(id: index, in: animationNamespace)
                                .onTapGesture {
                                    viewModel.action(.selectCard(index: index))
                                }
                        }
                    }
                }
                
                Spacer()
                PrimaryButton(title: "대화 완료", coordinator: Coordinator()) {
                    viewModel.action(.finishConversation)
                }
            }
            .padding(.horizontal, 24)
            
            popupCardView()
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

            QuestionCardView(index: cardIndex)
                .matchedGeometryEffect(id: cardIndex, in: animationNamespace)
                .transition(.scale.animation(.easeIn))
                .zIndex(2)
        }
    }
}

struct QuestionCardCell: View {
    var body: some View {
        Image("questionCard")
            .shadow(color: DiveColor.gray4.opacity(0.18), radius: 5, y: 5)
    }
}
