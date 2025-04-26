//
//  ProfileView.swift
//  DiverBook_iOS
//
//  Created by bear on 4/17/25.
//

import SwiftUI

struct DiverProfileView: View {
    @StateObject private var viewModel: DiverProfileViewModel

    init(viewModel: DiverProfileViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 26) {
                DiverProfileHeaderSectionView(
                    profileImageName: viewModel.state.profileImageName,
                    name: viewModel.state.name,
                    foundDate: viewModel.state.foundDate
                )

                TodayTalkSectionView(
                    mode: .readOnly(text: viewModel.state.todayTalk)
                )

                ProfileDetailsInfoView(
                    division: .readOnly(text: viewModel.state.division),
                    phoneNumber: .readOnly(text: viewModel.state.phoneNumber),
                    interests: .readOnly(text: viewModel.state.interests),
                    places: .readOnly(text: viewModel.state.places)
                )

                Spacer().frame(height: 12)

                DiverHistorySectionView(history: $viewModel.history)

                PrimaryButton(
                    title: "저장",
                    isEnabled: viewModel.isSaveEnabled,
                    color: .lighter,
                    coordinator: Coordinator(),
                    action: {
                        // 저장 액션 처리 예정
                    }
                )
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    DiverProfileView(viewModel: DiverProfileViewModel())
}
