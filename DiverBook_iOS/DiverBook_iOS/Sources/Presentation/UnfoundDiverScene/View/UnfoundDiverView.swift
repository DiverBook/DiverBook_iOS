//
//  UnfoundDiverView.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/27/25.
//

import SwiftUI

struct UnfoundDiverView: View {
    @StateObject var viewModel: UnfoundDiverViewModel
    @GestureState var dragOffset: CGSize = .zero
    @Environment(\.dismiss) var dismiss
    
    let diverName: String
    
    init(coordinator: Coordinator, diverName: String) {
        _viewModel = StateObject(wrappedValue: UnfoundDiverViewModel(coordinator: coordinator))
        self.diverName = diverName
    }
    
    var body: some View {
        VStack {
            UnfoundDiverTopBarView()
            Spacer()
            PrimaryProfile(
                imageURL: DiverProfile.unfoundMockData.profileImageUrl,
                nickname: diverName,
                style: .unfound
            )
            Text("아직 발견되지 않은 다이버입니다.")
                .font(DiveFont.bodyMedium1)
                .foregroundColor(DiveColor.gray3)
                .padding(.top, 60)
            Spacer()
            PrimaryButton(title: "다이버 탐색하기", coordinator: Coordinator()) {
                viewModel.action(.tabSearchButton)
            }
        }
        .padding(.horizontal, 24)
        .background(.white)
        .setBackGesture(dragOffset: $dragOffset, dismiss: { dismiss() })
    }
}
