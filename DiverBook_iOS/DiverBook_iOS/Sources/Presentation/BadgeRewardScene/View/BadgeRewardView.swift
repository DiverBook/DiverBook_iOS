//
//  BadgeRewardView.swift
//  DiverBook_iOS
//
//  Created by jun on 5/7/25.
//

import SwiftUI

struct BadgeRewardView: View {
    @StateObject var viewModel: BadenRewardViewModel

    init(coordinator: Coordinator) {
        _viewModel = StateObject(
            wrappedValue: BadenRewardViewModel(coordinator: coordinator)
        )
    }

    var body: some View {
        VStack {
            Spacer()
            
            Image("badge1")
                .resizable()
                .scaledToFit()
                .frame(width: 125, height: 177)
                .applyShadow(DiveShadow.shadow1)

            VStack {
                Text("다이버시티에서의 첫 발견!")
                HStack {
                    Text("‘첫 입수’")
                        .foregroundStyle(DiveColor.color6)
                    Text("뱃지를 획득했어요.")
                }
            }
            .font(DiveFont.headingH3)
            
            Spacer()

            PrimaryButton(title: "확인", coordinator: viewModel.coordinator) {
                viewModel.action(.confirmButtonTapped)
            }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    BadgeRewardView(coordinator: Coordinator())
}
