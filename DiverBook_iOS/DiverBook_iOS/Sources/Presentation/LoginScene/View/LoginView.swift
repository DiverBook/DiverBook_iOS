//
//  LoginView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/4/25.
//
import Combine
import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    
    init(nickname: String, coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(
            coordinator: coordinator,
            loginUseCase: DefaultLoginUseCase(
                loginRepository: DefaultLoginRepository(
                    loginService: DiverBookLoginService())),
            nickname: nickname))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TopBar()
                .padding(.horizontal, -4)
                .padding(.bottom, 10)
            switch viewModel.state.phase {
            case .checkDetectedInfo:
                CheckDetectedIDCardInfoView(nickname: viewModel.state.nickname)
            case .inputPassword:
                LoginInputPaswordView(viewModel: viewModel)
            }
            Spacer()
            Button(
                action: {
                    viewModel.action(.nextButtonTapped)
                },
                label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            viewModel.state.buttonAvailable
                                ? DiveColor.color6 : DiveColor.gray2
                        )
                        .frame(height: 55)
                        .overlay(
                            Text("다음")
                                .font(DiveFont.button)
                                .foregroundStyle(
                                    viewModel.state.buttonAvailable
                                        ? .white : DiveColor.gray3)
                        )
                }
            )
            .buttonStyle(.plain)
            .padding(.bottom, 10)
            .disabled(!viewModel.state.buttonAvailable)
        }
        .padding(.horizontal, 24)
        .background(Rectangle().fill(.white))
        .hideKeyboardOnTap()
    }
}
