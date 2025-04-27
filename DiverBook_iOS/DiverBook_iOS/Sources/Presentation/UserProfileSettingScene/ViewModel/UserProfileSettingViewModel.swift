//
//  UserProfileSettingViewModel.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/18/25.
//

import Combine
import SwiftUI

final class UserProfileSettingViewModel: ViewModelable {
    
    struct State {
        var profileSettingPhase: ProfileSettingPhase = .checkDetectedIDCardInfo
        var preferredField: PreferredField = .tech
        var phoneNumber: String = ""
        var interests: String = ""
        var preferredPlaces: String = ""
        var shortBio: String = ""
        
        var buttonAvailable: Bool = true
    }
    
    enum Action {
        case nextButtonTapped
        case profileSettingEnd
        case validateCurrentStepInfo
    }
    
    @ObservedObject var coordinator: Coordinator
    @Published var state: State = State()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
        switch action {
        case .nextButtonTapped:
            if self.state.profileSettingPhase != .checkDetectedIDCardInfo {
                withAnimation {
                    self.state.buttonAvailable = false
                }
            }
            
            guard let nextPhase = self.state.profileSettingPhase.nextPhase else {
                self.action(.profileSettingEnd)
                return
            }
            
            withAnimation {
                self.state.profileSettingPhase = nextPhase
            }
            
        case .profileSettingEnd:
            print("end!")
            
        case .validateCurrentStepInfo:
            switch self.state.profileSettingPhase {
            case .checkDetectedIDCardInfo:
                self.state.buttonAvailable = true
            case .selectPreferredField:
                self.state.buttonAvailable = true
            case .inputPhoneNumber:
                self.state.buttonAvailable = validatePhoneNumber(self.state.phoneNumber)
            case .inputInterest: // validate 기준은?
                self.state.buttonAvailable = true
            case .inputFrequentPlaces: // validate 기준은?
                self.state.buttonAvailable = true
            case .inputShortBio: // validate 기준은?
                self.state.buttonAvailable = true
            }
        }
    }
    
    func validatePhoneNumber(_ phoneNumber: String) -> Bool {
        return phoneNumber.count == 11
    }
}

enum ProfileSettingPhase {
    case checkDetectedIDCardInfo
    case selectPreferredField
    case inputPhoneNumber
    case inputInterest
    case inputFrequentPlaces
    case inputShortBio
    
    var nextPhase: Self? {
        switch self {
        case .checkDetectedIDCardInfo:
            .selectPreferredField
        case .selectPreferredField:
            .inputPhoneNumber
        case .inputPhoneNumber:
            .inputInterest
        case .inputInterest:
            .inputFrequentPlaces
        case .inputFrequentPlaces:
            .inputShortBio
        case .inputShortBio:
            nil
        }
    }
    
    var phaseStep: Int {
        switch self {
        case .checkDetectedIDCardInfo:
            return 1
        case .selectPreferredField:
            return 2
        case .inputPhoneNumber:
            return 3
        case .inputInterest:
            return 4
        case .inputFrequentPlaces:
            return 5
        case .inputShortBio:
            return 6
        }
    }
}

enum PreferredField: CaseIterable {
    case tech
    case design
    case domain
    
    var fieldDescription: String {
        switch self {
        case .tech:
            "테크"
        case .design:
            "디자인"
        case .domain:
            "도메인"
        }
    }
}

enum UserInfoType {
    case phoneNumber
    case inserests
    case preferredPlaces
    case shortBio
    
    var placeholder: String {
        switch self {
        case .phoneNumber:
            return "휴대폰 번호를 입력해주세요."
        case .inserests:
            return "관심사를 콤마로 구분하여 입력해주세요."
        case .preferredPlaces:
            return "자주 가는 장소를 콤마로 구분하여 입력해주세요."
        case .shortBio:
            return "한줄 소개를 입력해주세요."
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .phoneNumber:
            return .numberPad
        default:
            return .default
        }
    }
}
