//
//  QuestionCardGridView.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/27/25.
//

import SwiftUI

struct QuestionCardGridView: View {
    @StateObject var viewModel: ConversationViewModel
    @State private var degree: Double = 0
    @GestureState var dragOffset: CGSize = .zero
    @Environment(\.dismiss) var dismiss
    
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 2)
    let animationNamespace: Namespace.ID
    let diverId: String
    
    var body: some View {
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
                        QuestionCardBackView(degree: $degree)
                            .matchedGeometryEffect(id: index, in: animationNamespace)
                            .onTapGesture {
                                viewModel.action(.selectCard(index: index))
                            }
                    }
                }
            }
            
            Spacer()
            PrimaryButton(title: "대화 완료", coordinator: Coordinator()) {
                viewModel.action(.finishConversation(diverId: diverId))
            }
        }
        .padding(.horizontal, 24)
        .background(.white)
        .setBackGesture(dragOffset: $dragOffset, dismiss: { dismiss() })
    }
}
