//
//  SystemSettingViewModel.swift
//  DiverBook_iOS
//
//  Created by jun on 5/2/25.
//

import Foundation

final class SystemSettingViewModel: ViewModelable{
    struct State{
        var showWithdrawAlert: Bool = false
    }
    
    enum Action{
        case tapProfile
        case tapPolicy
        case tapWithdraw
        case dismissAlert
        case confirmWithdraw
    }
    
    @Published var state = State()
    
    func action(_ action: Action) {
        switch action {
        case .tapProfile:
            print("Navigate to: 내 프로필 관리")
        case .tapPolicy:
            print("Navigate to: 개인 정보 이용 약관")
        case .tapWithdraw:
            state.showWithdrawAlert = true
        case .dismissAlert:
            state.showWithdrawAlert = false
        case .confirmWithdraw:
            print("탈퇴 처리")
            state.showWithdrawAlert = false
        }
    }
}
