//
//  UserPro.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/18/25.
//

import Combine
import SwiftUI

struct UserProfileSettingView: View {
    @StateObject var viewModel: UserProfileSettingViewModel
    var nickname: String

    init(nickname: String, coordinator: Coordinator) {
        self.nickname = nickname
        _viewModel = StateObject(
            wrappedValue: UserProfileSettingViewModel(coordinator: coordinator))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TopBar()
                .padding(.horizontal, -4)
                .padding(.bottom, 10)

            if self.viewModel.state.profileSettingPhase
                == .checkDetectedIDCardInfo {
                CheckDetectedIDCardInfoView(nickname: self.nickname)
            } else {
                ScrollView {
                    InputUserDetailInfoView(viewModel: self.viewModel)
                }
                .scrollIndicators(.never)
                .frame(alignment: .leading)
            }

            Spacer()
            Button(
                action: {
                    self.viewModel.action(.nextButtonTapped)
                },
                label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            self.viewModel.state.buttonAvailable
                                ? DiveColor.color6 : DiveColor.gray2
                        )
                        .frame(height: 55)
                        .overlay(
                            Text("다음")
                                .font(DiveFont.button)
                                .foregroundStyle(
                                    self.viewModel.state.buttonAvailable
                                        ? .white : DiveColor.gray3)
                        )
                }
            )
            .buttonStyle(.plain)
            .padding(.bottom, 10)
            .disabled(!self.viewModel.state.buttonAvailable)
        }
        .padding(.horizontal, 24)
        .background(Rectangle().fill(.white))
        .hideKeyboardOnTap(action: {
            self.viewModel.action(.validateCurrentStepInfo)
        })
    }
}

#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    UserProfileSettingView(nickname: "abcd", coordinator: coordinator)
}
