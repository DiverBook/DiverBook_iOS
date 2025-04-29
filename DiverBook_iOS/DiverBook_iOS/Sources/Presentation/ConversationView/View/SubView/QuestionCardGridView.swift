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
    
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 2)
    var animationNamespace: Namespace.ID
    
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
                        QuestionCardCell(degree: $degree)
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
    }
}
