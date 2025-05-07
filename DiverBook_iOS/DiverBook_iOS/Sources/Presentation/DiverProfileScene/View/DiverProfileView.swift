//
//  ProfileView.swift
//  DiverBook_iOS
//
//  Created by bear on 4/17/25.
//

import SwiftUI

struct DiverProfileView: View {
    @StateObject private var viewModel: DiverProfileViewModel

    init(coordinator: Coordinator, diverId: String) {
        let fetchDiverProfileUseCase = DefaultFetchDiverProfileUseCase(
            repository: DefaultDiverRepository(
                diverProfileService: DiverProfileService()
            )
        )
        _viewModel = StateObject(
            wrappedValue: DiverProfileViewModel(
                fetchDiverProfileUseCase: fetchDiverProfileUseCase,
                diverId: diverId
            )
        )
    }

    var body: some View {
        VStack {
            DiverProfileTopBarView()

            if viewModel.state.isDataFetching {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 26) {
                        DiverProfileHeaderSectionView(
                            profileImageURL: viewModel.state.diverProfile
                                .profileImageUrl,
                            name: viewModel.state.diverProfile.userName,
                            //TODO: 서버에 발견일자 불러와야함, fetch 했을 때, foundDate 변수 없음
                            foundDate: "25.03.04"
                        )

                        TodayTalkSectionView(
                            mode: .readOnly(
                                text: viewModel.state.diverProfile.about
                            )
                        )

                        ProfileDetailsInfoView(
                            division: .readOnly(
                                text: viewModel.state.diverProfile.divisions
                            ),
                            phoneNumber: .readOnly(
                                text: viewModel.state.diverProfile.phoneNumber
                            ),
                            interests: .readOnly(
                                text: viewModel.state.diverProfile.interests
                            ),
                            places: .readOnly(
                                text: viewModel.state.diverProfile.places
                            )
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
                }
                .redacted(reason: .placeholder)
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 26) {
                        DiverProfileHeaderSectionView(
                            profileImageURL: viewModel.state.diverProfile
                                .profileImageUrl,
                            name: viewModel.state.diverProfile.userName,
                            //TODO: 서버에 발견일자 불러와야함, fetch 했을 때, foundDate 변수 없음
                            foundDate: "25.03.04"
                        )

                        TodayTalkSectionView(
                            mode: .readOnly(
                                text: viewModel.state.diverProfile.about
                            )
                        )

                        ProfileDetailsInfoView(
                            division: .readOnly(
                                text: viewModel.state.diverProfile.divisions
                            ),
                            phoneNumber: .readOnly(
                                text: viewModel.state.diverProfile.phoneNumber
                            ),
                            interests: .readOnly(
                                text: viewModel.state.diverProfile.interests
                            ),
                            places: .readOnly(
                                text: viewModel.state.diverProfile.places
                            )
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
                }
            }
        }
        .padding(.horizontal, 24)
        .onAppear {
            viewModel.action(.viewAppeared)
        }

    }
}

#Preview {
    DiverProfileView(coordinator: Coordinator(), diverId: "dummy-id")
}

struct DiverProfileTopBarView: View {
    var body: some View {
        ZStack {
            TopBar()
            Text("다이버 카드")
                .font(DiveFont.bar)
                .foregroundStyle(DiveColor.gray4)
        }
    }
}
