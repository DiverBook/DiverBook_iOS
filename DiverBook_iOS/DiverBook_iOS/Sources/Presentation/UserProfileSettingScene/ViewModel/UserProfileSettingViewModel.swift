//
//  UserProfileSettingViewModel.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/18/25.
//

import Combine
import SwiftUI

class UserProfileSettingViewModel: ViewModelable {
    struct State {
        var authUseCase: AuthUseCase
        var diverProfileUseCase: FetchDiverProfileUseCase
        var profileSettingPhase: ProfileSettingPhase = .checkDetectedIDCardInfo
        var nickName: String
        var profileImageUrl: String?
        var password: String = ""
        var preferredField: PreferredField = .tech
        var phoneNumber: String = ""
        var interests: String = ""
        var preferredPlaces: String = ""
        var shortBio: String = ""
        
        var buttonAvailable: Bool = true
    }
    
    enum Action {
        case viewAppeared
        case nextButtonTapped
        case profileSettingEnd
        
        // MARK: validate
        case validatePassword
        case validateShortBio
        case validatePreferredPlaces
        case validateInterests
        case validatePhoneNumber
        case validatePreferredField
    }
    
    @ObservedObject var coordinator: Coordinator
    @Published var state: State
    
    init(coordinator: Coordinator, authUseCase: AuthUseCase, diverProfileUseCase: FetchDiverProfileUseCase, nickName: String) {
        self.coordinator = coordinator
        self.state = State(authUseCase: authUseCase, diverProfileUseCase: diverProfileUseCase, nickName: nickName)
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewAppeared:
            Task {
                let profileImageUrlResult = await state.diverProfileUseCase.executeFetchProfileImageUrl(nickName: state.nickName)
                switch profileImageUrlResult {
                case .success(let profileImageUrl):
                    state.profileImageUrl = profileImageUrl
                case .failure(let error):
                    print(error)
                }
            }
            
        case .nextButtonTapped:
            guard let nextPhase = self.state.profileSettingPhase.nextPhase else {
                self.action(.profileSettingEnd)
                return
            }
            
            withAnimation {
                self.state.profileSettingPhase = nextPhase
            }
            
            if state.profileSettingPhase == .checkDetectedIDCardInfo || state.profileSettingPhase == .selectPreferredField {
                withAnimation {
                    self.state.buttonAvailable = true
                }
            } else {
                withAnimation {
                    self.state.buttonAvailable = false
                }
            }
            
        case .profileSettingEnd:
            Task { [weak self] in
                if let self = self {
                    let result = await self.state.authUseCase.executeSignUp(
                        userName: self.capitalizeNickname(nickName: state.nickName),
                        divisions: self.state.preferredField.fieldDescription,
                        phoneNumber: self.state.phoneNumber,
                        interests: self.state.interests,
                        places: self.state.preferredPlaces,
                        about: self.state.shortBio,
                        password: self.state.password
                    )
                    switch result {
                    case .success:
                        coordinator.push(.mainTab)
                    case .failure:
                        print("fail")
                    }
                }
            }
            
        case .validatePassword:
             state.buttonAvailable = validatePassword(password: state.password)
            
        case .validateShortBio:
            state.buttonAvailable = validateInfoSettingPage()
            if state.shortBio.count > 20 {
                state.shortBio = String(state.shortBio.dropLast())
            }
            
        case .validatePreferredPlaces:
            state.buttonAvailable = validateInfoSettingPage()
            
        case .validateInterests:
            state.buttonAvailable = validateInfoSettingPage()
            
        case .validatePhoneNumber:
            state.buttonAvailable = validateInfoSettingPage()
            
        case .validatePreferredField:
            state.buttonAvailable = validateInfoSettingPage()
        }
    }
    
    private func validateInfoSettingPage() -> Bool {
        var isValid = false
        if state.profileSettingPhase.phaseStep >=  3 {
            isValid = validatePreferredField(preferredField: state.preferredField)
            if !isValid {
                return isValid
            }
        }
        if state.profileSettingPhase.phaseStep >= 4 {
            isValid = validatePhoneNumber(state.phoneNumber)
            if !isValid {
                return isValid
            }
        }
        if state.profileSettingPhase.phaseStep >= 5 {
            isValid = validateInterests(interests: state.interests)
            if !isValid {
                return isValid
            }
        }
        if state.profileSettingPhase.phaseStep >= 6 {
            isValid = validateFrequentPlaces(frequentPlaces: state.preferredPlaces)
            if !isValid {
                return isValid
            }
        }
        if state.profileSettingPhase.phaseStep >= 7 {
            isValid = validateShortBio(shortBio: state.shortBio)
        }
        return isValid
    }
    
    private func validatePassword(password: String) -> Bool {
        if password.count == 4 {
            guard Int(password) != nil else {
                return false
            }
            return true
        }
        return false
    }

    private func validateInterests(interests: String) -> Bool {
        return !interests.isEmpty
    }
    
    private func validateFrequentPlaces(frequentPlaces: String) -> Bool {
        return !frequentPlaces.isEmpty
    }
    
    private func validateShortBio(shortBio: String) -> Bool {
        return !shortBio.isEmpty
    }
    
    private func validatePhoneNumber(_ phoneNumber: String) -> Bool {
        return phoneNumber.count == 11
    }
    
    private func validatePreferredField(preferredField: PreferredField) -> Bool {
        return true
    }
    
    private func capitalizeNickname(nickName: String) -> String {
        return String(state.nickName.uppercased().first!) + String(state.nickName.dropFirst().lowercased())
    }
}

enum ProfileSettingPhase {
    case inputPassword
    case checkDetectedIDCardInfo
    case selectPreferredField
    case inputPhoneNumber
    case inputInterest
    case inputFrequentPlaces
    case inputShortBio
    
    var nextPhase: Self? {
        switch self {
        case .checkDetectedIDCardInfo:
                .inputPassword
        case .inputPassword:
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
        case .inputPassword:
            return 1
        case .checkDetectedIDCardInfo:
            return 2
        case .selectPreferredField:
            return 3
        case .inputPhoneNumber:
            return 4
        case .inputInterest:
            return 5
        case .inputFrequentPlaces:
            return 6
        case .inputShortBio:
            return 7
        }
    }
    
    var phaseNotifyString: String {
        switch self {
        case .selectPreferredField:
            return "희망분야를 선택해주세요."
        case .inputPhoneNumber:
            return "전화번호를 입력해주세요."
        case .inputInterest:
            return "관심사를 입력해주세요."
        case .inputFrequentPlaces:
            return "자주 가는 장소를 입력해주세요."
        case .inputShortBio:
            return "한 줄 소개를 입력해주세요."
        default:
            return ""
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
