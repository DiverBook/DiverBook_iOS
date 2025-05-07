//
//  MyProfileViewModel.swift
//  DiverBook_iOS
//
//  Created by jun on 4/27/25.
//

import Combine
import Foundation
import SwiftUI

final class MyProfileViewModel: ViewModelable {
    struct State {
        var isDataFetching : Bool = false
        var myProfile: DiverProfile = DiverProfile.mockData
        
        var todayTalk: String = ""
        var division: String = ""
        var phoneNumber: String = ""
        var interests: String = ""
        var places: String = ""
        var badgeCount: Int = 0
        var nickname: String = ""
        
        var errorMessage: String = ""
        var isErrorShowing: Bool = false
        
    }

    enum Action {
        case viewAppeared
        case updateTodayTalk(String)
        case updateDivision(String)
        case updatePhoneNumber(String)
        case updateInterests(String)
        case updatePlaces(String)
    }

    @Published var state = State()
    
    @ObservedObject var coordinator: Coordinator

    private var cancellables = Set<AnyCancellable>()
    
    //UseCases
    private let fetchDiverProfileUseCase: FetchDiverProfileUseCase
    private let fetchRefreshTokenUseCase: FetchRefreshTokenUseCase

    init(
        coordinator: Coordinator,
        fetchDiverProfileUseCase: FetchDiverProfileUseCase,
        fetchRefreshTokenUseCase: FetchRefreshTokenUseCase
    ) {
        self.coordinator = coordinator
        self.fetchDiverProfileUseCase = fetchDiverProfileUseCase
        self.fetchRefreshTokenUseCase = fetchRefreshTokenUseCase
        observeStateChanges()
    }

    func action(_ action: Action) {
        switch action {
        case .viewAppeared:
            state.isDataFetching = true
            Task{
                await fetchMyProfile()
                state.isDataFetching = false
            }
            
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

    private func fetchMyProfile() async {
        let myProfileResult = await TokenRefreshHandler.withTokenRefresh(
            operation: {
                await self.fetchDiverProfileUseCase.executeFetchMyProfile()
            },
            refreshTokenUseCase: fetchRefreshTokenUseCase
        )

        switch myProfileResult {
        case .success(let profile):
            state.myProfile = profile
        case .failure(let error):
            activateErrorAlert(message: "사용자 정보 조회에 실패하였습니다.")
        }
    }

    private func observeStateChanges() {
        $state
            .dropFirst()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] newState in
                self?.updateProfile()
            }
            .store(in: &cancellables)
    }

    private func updateProfile() {
        // TODO: PATCH 로직 연결 필요 (예: UpdateProfileUseCase)
        print("✅ 자동 저장 요청 준비됨")
    }
    
    private func activateErrorAlert(message: String) {
        state.errorMessage = message
        state.isErrorShowing = true
    }
}
