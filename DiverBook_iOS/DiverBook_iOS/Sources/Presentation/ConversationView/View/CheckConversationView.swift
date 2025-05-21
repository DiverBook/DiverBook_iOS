//
//  CheckConversationView.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/17/25.
//

import SwiftUI

struct CheckConversationView: View {
    @StateObject var viewModel: CheckConversationViewModel
    @GestureState var dragOffset: CGSize = .zero
    @Environment(\.dismiss) var dismiss
    
    init(coordinator: Coordinator, diverId: String) {
        let saveDiverMemoUseCase = DefaultSaveDiverMemoUseCase(
            diverCollectionRepository: DefaultDiverCollectionRepository(
                diverCollectionService: DiverCollectionService()
            )
        )
        
        _viewModel = StateObject(
            wrappedValue: CheckConversationViewModel(
                coordinator: coordinator,
                diverId: diverId,
                saveDiverMemoUseCase: saveDiverMemoUseCase
            )
        )
    }
    
    var body: some View {
        VStack(alignment: .center) {
            TopBar()
                .padding(.top, 50)
                .padding(.bottom, 50)
                .padding(.horizontal, 24)
            Text("상대 다이버의\n대화 완료를 기다리는 중이에요")
                .font(DiveFont.headingH3)
                .foregroundColor(DiveColor.gray4)
                .padding(.bottom, 25)
                .multilineTextAlignment(.center)
                .frame(height: 80)
            Text("모두 대화 완료시 도감을 획득할 수 있습니다")
                .font(DiveFont.bodyMedium1)
                .foregroundColor(DiveColor.gray4)
                .multilineTextAlignment(.center)
            Spacer()
            LottieView(animationName: "ProgressAnimation", shouldPlay: true)
                .frame(height: 600)
        }
        .onAppear {
            viewModel.action(.sendFinishConversation)
        }
        .onDisappear {
            viewModel.stopSearching()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(.white)
        .setBackGesture(dragOffset: $dragOffset, dismiss: { dismiss() })
    }
}
