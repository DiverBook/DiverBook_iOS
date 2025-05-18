//
//  BadgeRewardView.swift
//  DiverBook_iOS
//
//  Created by jun on 5/7/25.
//

import SwiftUI

struct BadgeRewardView: View {
    @StateObject private var viewModel: BadgeRewardViewModel

    init(coordinator: Coordinator, badgeCode: String) {
        _viewModel = StateObject(
            wrappedValue: BadgeRewardViewModel(coordinator: coordinator, badgeCode: badgeCode)
        )
    }

    var body: some View {
        VStack {
            Spacer()
            
            Image(viewModel.state.badgeImage)
                .resizable()
                .scaledToFit()
                .frame(width: 125, height: 177)
                .applyShadow(DiveShadow.shadow1)

            VStack(spacing: 4) {
                Text("\(viewModel.state.rewardDesription)")
                
                HStack {
                    Text("'\(viewModel.state.badgeName)'")
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
        .onAppear {
            viewModel.loadBadge()
        }
    }
}
