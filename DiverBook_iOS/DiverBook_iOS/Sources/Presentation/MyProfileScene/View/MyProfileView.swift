//
//  MyProfileView.swift
//  DiverBook_iOS
//
//  Created by jun on 4/26/25.
//

import SwiftUI

struct MyProfileView: View {
    @StateObject private var viewModel: MyProfileViewModel

    init(viewModel: MyProfileViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 34) {
            VStack(spacing: 8) {
                PrimaryProfile(image: Image("exMemoji"), style: .mypage)

                Text("Air")
                    .font(DiveFont.headingH3)
            }

            TodayTalkSectionView(mode: .editable(binding: $viewModel.state.todayTalk))

            ProfileDetailsInfoView(
                division: viewModel.state.division,
                phoneNumber: viewModel.state.phoneNumber,
                interests: viewModel.state.interests,
                places: viewModel.state.places
            )
            
            CollectedBadgeButtonView(badgeCount: viewModel.state.badgeCount)
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    MyProfileView(viewModel: MyProfileViewModel())
}
