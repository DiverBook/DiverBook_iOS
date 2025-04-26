//
//  MyProfileViewModel.swift
//  DiverBook_iOS
//
//  Created by jun on 4/27/25.
//

import Combine
import Foundation

final class MyProfileViewModel: ViewModelable {
    struct State {
        var todayTalk: String = ""
        var division: String = ""
        var phoneNumber: String = ""
        var interests: String = ""
        var places: String = ""
        var badgeCount: Int = 0
    }

    enum Action {
        case fetchProfileData
        case updateTodayTalk(String)
        case updateDivision(String)
        case updatePhoneNumber(String)
        case updateInterests(String)
        case updatePlaces(String)
    }

    @Published var state = State()
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        action(.fetchProfileData)
        observeStateChanges()
    }
    
    func action(_ action: Action) {
        switch action {
        case .fetchProfileData:
            fetchProfileData()
            
        case .updateTodayTalk(let newTalk):
            state.todayTalk = newTalk
            
        case .updateDivision(let newDivision):
            state.division = newDivision
            
        case .updatePhoneNumber(let newPhoneNumber):
            state.phoneNumber = newPhoneNumber
            
        case .updateInterests(let newInterests):
            state.interests = newInterests
            
        case .updatePlaces(let newPlaces):
            state.places = newPlaces
        }
    }
    
    private func fetchProfileData() {
        // TODO: Mock 데이터 -> 서버 데이터 불러오기로 변경해야함
        self.state = State(
            todayTalk: "공기는 눈에 보이지 않지만 어디에나 있습니다.",
            division: "디자인",
            phoneNumber: "010-1234-1234",
            interests: "사진, 아마스빈",
            places: "C5",
            badgeCount: 5
        )
    }
    
    private func observeStateChanges() {
        $state
            .dropFirst()
            .sink { [weak self] newState in
                self?.saveProfileData(newState)
            }
            .store(in: &cancellables)
    }
    
    private func saveProfileData(_ state: State) {
        // TODO: 서버 저장 로직으로 변경해야함
        print("✅ 자동 저장: \(state.todayTalk), \(state.division), ...")
    }
}
