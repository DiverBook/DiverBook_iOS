//
//  ConversationView.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/23/25.
//

import SwiftUI

struct ConversationView: View {
    @StateObject var viewModel: ConversationViewModel
    
    init(coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: ConversationViewModel(coordinator: coordinator))
    }
    
    let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 0), count: 2)
    
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
                    QuestionCardCell()
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

struct QuestionCardCell: View {
    var body: some View {
        ZStack {
            Image("questionCard")
                .shadow(color: DiveColor.gray4.opacity(0.18), radius: 5, y: 5)
        }
    }
}
