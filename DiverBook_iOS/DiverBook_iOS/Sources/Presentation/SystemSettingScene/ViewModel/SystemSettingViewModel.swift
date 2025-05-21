//
//  SystemSettingViewModel.swift
//  DiverBook_iOS
//
//  Created by jun on 5/2/25.
//

import Combine
import Foundation
import SwiftUICore
import UIKit

final class SystemSettingViewModel: ViewModelable {
    struct State {
        var showLogoutAlert: Bool = false
        var showWithdrawAlert: Bool = false
    }

    enum Action {
        case tapProfile
        case tapPolicy
        case tapLogout
        case tapWithdraw
        case dismissAlert
        case confirmLogout
        case confirmWithdraw
    }

    @Published var state = State()
    @ObservedObject var coordinator: Coordinator

    private let deactivateUserUseCase: DeactivateUserUseCase
    private let logoutUseCase: LogoutUseCase

    private let privacyPolicyURLString =
        "https://comnovia.notion.site/1d87c806d35a80bea6dee416d05db411?pvs=4"

    init(
        coordinator: Coordinator,
        deactivateUserUseCase: DeactivateUserUseCase,
        logoutUseCase: LogoutUseCase
    ) {
        self.coordinator = coordinator
        self.deactivateUserUseCase = deactivateUserUseCase
        self.logoutUseCase = logoutUseCase
    }

    func action(_ action: Action) {
        switch action {
        case .tapProfile:
            coordinator.push(.myProfile)
        case .tapPolicy:
            if let url = URL(string: privacyPolicyURLString) {
                UIApplication.shared.open(url)
            }
        case .tapWithdraw:
            state.showWithdrawAlert = true
        case .tapLogout:
            state.showLogoutAlert = true
        case .dismissAlert:
            state.showWithdrawAlert = false
            state.showLogoutAlert = false
        case .confirmLogout:
            state.showLogoutAlert = false
            Task {
                let result = await logoutUseCase.executeLogout(
                    refreshToken: UserToken.refreshToken
                )
                switch result {
                case .success:
                    print("로그아웃 성공")
//                    UserToken.clear()
                    await MainActor.run {
                        coordinator.path = [.splash]
                    }
                case .failure(let error):
                    print("❌ 로그아웃 실패: \(error)")
                }
            }
        case .confirmWithdraw:
            state.showWithdrawAlert = false
            Task {
                let result = await deactivateUserUseCase.execute(
                    refreshToken: UserToken.refreshToken
                )
                switch result {
                case .success:
                    print("✅ 회원 탈퇴 성공")
                    await MainActor.run {
                        coordinator.path = [.splash]
                    }
                case .failure(let error):
                    if let requestError = error as? RequestError {
                        print("❌ 로그아웃 실패: \(requestError.message)")
                    }
                }
            }
        }
    }
}
