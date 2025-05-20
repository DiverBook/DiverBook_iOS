//
//  SystemSettingView.swift
//  DiverBook_iOS
//
//  Created by jun on 5/2/25.
//

import SwiftUI

struct SystemSettingView: View {
    @StateObject private var viewModel: SystemSettingViewModel

    init(coordinator: Coordinator) {
        let deactivateUserUseCase = DefaultDeactivateUserUseCase(
            repository: DefaultUserDeactivateRepository(
                userDeactivateService: UserDeactivateService()
            )
        )

        let logoutUseCase = DefaultLogoutUseCase(
            logoutRepository: DefaultLogoutRepository(
                logoutService: DiverBookLogoutService()
            )
        )

        _viewModel = StateObject(
            wrappedValue: SystemSettingViewModel(
                coordinator: coordinator,
                deactivateUserUseCase: deactivateUserUseCase,
                logoutUseCase: logoutUseCase
            )
        )
    }

    var body: some View {
        VStack {
            ZStack {
                TopBar(showBackButton: false)
                Text("설정")
                    .font(DiveFont.bar)
                    .foregroundColor(DiveColor.gray4)
            }

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 32) {
                    SettingRowView(title: "내 프로필 관리") {
                        viewModel.action(.tapProfile)
                    }

                    SettingRowView(title: "개인정보 이용 약관") {
                        viewModel.action(.tapPolicy)
                    }

                    SettingRowView(title: "로그아웃") {
                        viewModel.action(.tapLogout)
                    }

                    SettingRowView(title: "회원탈퇴") {
                        viewModel.action(.tapWithdraw)
                    }

                    Spacer().frame(height: 10)

                    VersionInfoView()

                    Spacer()
                }
            }
        }
        .padding(.horizontal, 24)
        .alert(
            "정말 회원탈퇴 하시겠습니까?",
            isPresented: $viewModel.state.showWithdrawAlert
        ) {
            Button("취소", role: .cancel) {
                viewModel.action(.dismissAlert)
            }
            Button("탈퇴", role: .destructive) {
                viewModel.action(.confirmWithdraw)
            }
        }
        .alert("로그아웃 하시겠습니까?", isPresented: $viewModel.state.showLogoutAlert) {
            Button("취소", role: .cancel) {
                viewModel.action(.dismissAlert)
            }
            Button("로그아웃", role: .destructive) {
                viewModel.action(.confirmLogout)
            }
        }
    }
}
