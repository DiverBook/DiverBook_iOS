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
        _viewModel = StateObject(
            wrappedValue: SystemSettingViewModel(
                coordinator: coordinator,
                deactivateUserUseCase: deactivateUserUseCase
            )
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            HStack {
                Spacer()
                Text("설정")
                    .font(DiveFont.bar)
                    .foregroundColor(DiveColor.gray4)
                Spacer()
            }

            SettingRowView(title: "내 프로필 관리") {
                viewModel.action(.tapProfile)
            }

            SettingRowView(title: "개인정보 이용 약관") {
                viewModel.action(.tapPolicy)
            }

            SettingRowView(title: "회원탈퇴") {
                viewModel.action(.tapWithdraw)
            }

            Spacer().frame(height: 10)

            VersionInfoView()

            Spacer()

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
    }
}
