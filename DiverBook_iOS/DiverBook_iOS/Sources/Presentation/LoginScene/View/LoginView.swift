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
    @GestureState var dragOffset: CGSize = .zero
    
    init(nickname: String, coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(
            coordinator: coordinator,
            diverProfileUseCase: DefaultFetchDiverProfileUseCase(
                repository: DefaultDiverRepository(
                    diverProfileService: DiverProfileService()
                )
            ),
            loginUseCase: DefaultLoginUseCase(
                loginRepository: DefaultLoginRepository(
                    loginService: DiverBookLoginService())),
            nickname: nickname))
    }
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack(alignment: .top) {
            LoginContentView(viewModel: viewModel)
            .padding(.horizontal, 24)
            .background(Rectangle().fill(.white))
            .hideKeyboardOnTap()
            ServiceErrorAlert(message: viewModel.state.errorMessage, showErrorAlert: $viewModel.state.errorAlertShowing)
        }
        .background(.white)
        .setBackGesture(
            dragOffset: $dragOffset,
            dismiss: { dismiss() }
        )
    }
}
