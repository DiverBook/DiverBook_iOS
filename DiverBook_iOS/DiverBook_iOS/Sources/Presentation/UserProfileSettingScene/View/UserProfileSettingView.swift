//
//  UserPro.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/18/25.
//

import Combine
import SwiftUI

struct UserProfileSettingView: View {
    @StateObject private var viewModel: UserProfileSettingViewModel
    @GestureState var dragOffset: CGSize = .zero
    var nickName: String

    init(nickName: String, coordinator: Coordinator) {
        self.nickName = nickName
        _viewModel = StateObject(
            wrappedValue: UserProfileSettingViewModel(
                coordinator: coordinator,
                authUseCase: DefaultAuthUseCase(
                    authRepository: DefaultAuthRepository(
                        authService: DiverBookAuthService(),
                        tokenService: DiverBookTokenService()
                    )
                ),
                diverProfileUseCase: DefaultFetchDiverProfileUseCase(
                    repository: DefaultDiverRepository(
                        diverProfileService: DiverProfileService()
                    )
                ),
                nickName: nickName
            )
        )
    }

    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TopBar()
                .padding(.horizontal, -4)
                .padding(.bottom, 10)

            if self.viewModel.state.profileSettingPhase
                == .checkDetectedIDCardInfo {
                CheckDetectedIDCardInfoView(
                    diverProfileImageUrl: URL(
                        string: viewModel.state.profileImageUrl ?? ""
                    ),
                    nickname: self.nickName
                )
            } else if viewModel.state.profileSettingPhase == .inputPassword {
                SignUpPasswordInputView(viewModel: viewModel)
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
        .setBackGesture(
            dragOffset: $dragOffset,
            dismiss: { dismiss() }
        )
        .hideKeyboardOnTap()
        .onAppear {
            viewModel.action(.viewAppeared)
        }
    }
}
