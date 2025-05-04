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
        VStack {
            DiverProfileTopBarView()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    PrimaryProfile(image: Image("exMemoji"), style: .mypage)

                    Text("Air")
                        .font(DiveFont.headingH3)
                }

                TodayTalkSectionView(
                    mode: .editable(binding: $viewModel.state.todayTalk)
                )

                Spacer().frame(height: 40)

                ProfileDetailsInfoView(
                    division: .editable(binding: $viewModel.state.division),
                    phoneNumber: .editable(
                        binding: $viewModel.state.phoneNumber
                    ),
                    interests: .editable(binding: $viewModel.state.interests),
                    places: .editable(binding: $viewModel.state.places)
                )

                Spacer().frame(height: 32)

                CollectedBadgeButtonView(badgeCount: viewModel.state.badgeCount)

                Spacer()

            }
        }
        .padding(.horizontal, 20)
    }

}

#Preview {
    MyProfileView(viewModel: MyProfileViewModel())
}
