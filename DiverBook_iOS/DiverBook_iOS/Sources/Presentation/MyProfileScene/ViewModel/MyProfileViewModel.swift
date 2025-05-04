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
            todayTalk: DiverProfile.mockData.about,
            division: DiverProfile.mockData.divisions,
            phoneNumber: DiverProfile.mockData.phoneNumber,
            interests: DiverProfile.mockData.interests,
            places: DiverProfile.mockData.places,
            badgeCount: 5
        )
    }
    
    private func observeStateChanges() {
        $state
            .dropFirst()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] newState in
                self?.saveProfileData(newState)
            }
            .store(in: &cancellables)
    }
    
    private func saveProfileData(_ state: State) {
        // TODO: 서버 저장 로직으로 변경해야함
        print("✅ 자동 저장: \(state.todayTalk), \(state.division), \(state.phoneNumber), \(state.interests), \(state.places)")
    }
}
