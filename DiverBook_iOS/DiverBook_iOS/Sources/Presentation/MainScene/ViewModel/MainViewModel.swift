//
//  MainViewModel.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/7/25.
//

import Combine
import SwiftUI

final class MainViewModel: ViewModelable {
    struct State {
        var isDataFetching: Bool = false
        var myProfile: DiverProfile = DiverProfile.mockData
        var bookAttainmentRate: Double = 0
        
        // diver collection list
        var diverProfiles: [DiverProfile] = []
        var isFoundedDiver: [String: Bool] = [:]
        
        // error alert
        var errorMessage: String = ""
        var isErrorShowing: Bool = false
    }
    
    enum Action {
        case viewAppeared
        case profileSettingButtonTapped
        case diverTapped
    }
    
    @Published var state: State = State()
    
    @ObservedObject var coordinator: Coordinator
    
    // useCases
    private let fetchDiverProfileUseCase: FetchDiverProfileUseCase
    private let collectionRateUseCase: DiverCollectionRateUseCase
    private let collectionUseCase: DiverCollectionUseCase
    private let fetchRefreshTokenUseCase: FetchRefreshTokenUseCase
    
    init(
        coordinator: Coordinator,
        fetchDiverProfileUseCase: FetchDiverProfileUseCase,
        collectionRateUseCase: DiverCollectionRateUseCase,
        collectionUseCase: DiverCollectionUseCase,
        fetchRefreshTokenUseCase: FetchRefreshTokenUseCase
    ) {
        self.coordinator = coordinator
        self.fetchDiverProfileUseCase = fetchDiverProfileUseCase
        self.collectionRateUseCase = collectionRateUseCase
        self.collectionUseCase = collectionUseCase
        self.fetchRefreshTokenUseCase = fetchRefreshTokenUseCase
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewAppeared:
            state.isDataFetching = true
            Task {
                await fetchMyProfile()
                await fetchDiverCollectionRate()
                await fetchAllDiverList()
                await fetchDiverCollection()
                state.isDataFetching = false
            }
            
        case .profileSettingButtonTapped:
            print("profile setting button tapped!")
        case .diverTapped:
            print("diver tapped!")
        }
    }
    
    private func fetchMyProfile() async {
        let myProfileResult = await TokenRefreshHandler.withTokenRefresh(
            operation: {
                await self.fetchDiverProfileUseCase.executeFetchMyProfile()
            },
            refreshTokenUseCase: fetchRefreshTokenUseCase)
        
        switch myProfileResult {
        case .success(let myProfile):
            state.myProfile = myProfile
        case .failure(let error):
            activateErrorAlert(message: "사용자 정보 조회에 실패하였습니다.")
        }
    }
    
    private func fetchDiverCollectionRate() async {
        let diverCollectionRateResult = await TokenRefreshHandler.withTokenRefresh(
            operation: {
                await self.collectionRateUseCase.executeFetchDiverCollectionRate(id: UserToken.id)
            },
            refreshTokenUseCase: fetchRefreshTokenUseCase)
        
        switch diverCollectionRateResult {
        case .success(let collectionRate):
            state.bookAttainmentRate = Double(collectionRate)
        case .failure:
            activateErrorAlert(message: "도감 달성률 조회에 실패하였습니다.")
        }
    }
    
    private func fetchAllDiverList() async {
        let allDiverListResult = await TokenRefreshHandler.withTokenRefresh(
            operation: {
                await self.collectionUseCase.executeFetchAllDiverList()
            },
            refreshTokenUseCase: fetchRefreshTokenUseCase
        )
        
        switch allDiverListResult {
        case .success(let diverProfiles):
            state.diverProfiles = diverProfiles
            for diverProfile in diverProfiles {
                state.isFoundedDiver[diverProfile.id] = false
            }
        case .failure:
            activateErrorAlert(message: "도감 유저 리스트 조회에 실패하였습니다.")
        }
    }
    
    // MARK: 나의 도감 collect 상태 가져오기
    private func fetchDiverCollection() async {
        let diverCollectionResult = await TokenRefreshHandler.withTokenRefresh(
            operation: {
                await self.collectionUseCase.executeFetchDiverCollection()
            },
            refreshTokenUseCase: fetchRefreshTokenUseCase
        )
        
        switch diverCollectionResult {
        case .success(let diverProfiles):
            // MARK: 현재 내가 수집한 다이버 리스트
            for diverProfile in diverProfiles {
                state.isFoundedDiver[String(diverProfile.id)] = true
            }
        case .failure:
            activateErrorAlert(message: "도감 사용자 리스트 조회에 실패하였습니다.")
        }
    }
    
    private func activateErrorAlert(message: String) {
        state.errorMessage = message
        state.isErrorShowing = true
    }
}
