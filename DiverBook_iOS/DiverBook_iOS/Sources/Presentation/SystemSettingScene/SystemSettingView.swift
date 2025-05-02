//
//  SystemSettingView.swift
//  DiverBook_iOS
//
//  Created by jun on 5/2/25.
//

import SwiftUI

struct SystemSettingView: View {
    @StateObject private var viewModel: SystemSettingViewModel

    init(viewModel: SystemSettingViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
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
        .padding(24)
        .navigationTitle("설정")
        .navigationBarTitleDisplayMode(.inline)
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

#Preview {
    SystemSettingView(viewModel: SystemSettingViewModel())
}
