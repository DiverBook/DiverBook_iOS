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
        var showWithdrawAlert: Bool = false
    }

    enum Action {
        case tapProfile
        case tapPolicy
        case tapWithdraw
        case dismissAlert
        case confirmWithdraw
    }

    @Published var state = State()
    @ObservedObject var coordinator: Coordinator

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func action(_ action: Action) {
        switch action {
        case .tapProfile:
            coordinator.push(.myProfile)
        case .tapPolicy:
            if let url = URL(string: "https://comnovia.notion.site/1d87c806d35a80bea6dee416d05db411?pvs=4") {
                UIApplication.shared.open(url)
            }
        case .tapWithdraw:
            state.showWithdrawAlert = true
        case .dismissAlert:
            state.showWithdrawAlert = false
        case .confirmWithdraw:
            print("탈퇴 처리")
            //TODO: 탈퇴 로직 추가
            state.showWithdrawAlert = false
        }
    }
}
