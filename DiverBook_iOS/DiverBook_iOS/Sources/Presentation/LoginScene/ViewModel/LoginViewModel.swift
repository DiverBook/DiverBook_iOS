//
//  LoginViewModel.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/4/25.
//

import Combine
import SwiftUI

class LoginViewModel: ViewModelable {
    struct State {
        var nickname: String
        var password: String = ""
        var phase: LoginPhase = .checkDetectedInfo
        var buttonAvailable: Bool = true
    }
    
    enum Action {
        case validatePassword
        case nextButtonTapped
    }
    
    private var loginUseCase: LoginUseCase
    
    @ObservedObject var coordinator: Coordinator
    @Published var state: State
    
    init(coordinator: Coordinator, loginUseCase: LoginUseCase, nickname: String) {
        self.coordinator = coordinator
        self.loginUseCase = loginUseCase
        self.state = State(nickname: nickname)
    }
    
    func action(_ action: Action) {
        switch action {
        case .validatePassword:
            validatePassword(password: state.password)
        case .nextButtonTapped:
            switch state.phase {
            case .checkDetectedInfo:
                state.phase = .inputPassword
            case .inputPassword:
                Task {
                    let result = await isCorrectPassword(userName: state.nickname, password: state.password)
                    switch result {
                    case .success:
                        coordinator.push(.mainTab)
                    case .failure(let errorMessage):
                        // TODO: 로그인 실패 모달 띄우기 (비밀번호 불일치)
                        print(errorMessage)
                    }
                }
            }
        }
    }
    
    private func validatePassword(password: String) -> Bool {
        return password.count == 4
    }
    
    private func isCorrectPassword(userName: String, password: String) async -> DiverBookResult {
        let loginResult = await loginUseCase.executeLogin(userName: userName, password: password)
        switch loginResult {
        case .success(let success):
            return .success
        case .failure(let error):
            if let error = error as? RequestError {
                print(error.message)
                return .failure(error.message)
            }
            return .failure("알 수 없는 에러가 발생하였습니다.")
        }
    }
}

enum LoginPhase {
    case checkDetectedInfo
    case inputPassword
}

enum DiverBookResult {
    case success
    case failure(String)
}
