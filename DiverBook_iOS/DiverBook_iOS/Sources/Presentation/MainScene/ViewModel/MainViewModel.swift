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
        var userNickname: String = DiverProfile.mockData.userName
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
    private let collectionRateUseCase: DiverCollectionRateUseCase
    private let collectionUseCase: DiverCollectionUseCase
    private let fetchRefreshTokenUseCase: FetchRefreshTokenUseCase
    
    init(
        coordinator: Coordinator,
        collectionRateUseCase: DiverCollectionRateUseCase,
        collectionUseCase: DiverCollectionUseCase,
        fetchRefreshTokenUseCase: FetchRefreshTokenUseCase
    ) {
        self.coordinator = coordinator
        self.collectionRateUseCase = collectionRateUseCase
        self.collectionUseCase = collectionUseCase
        self.fetchRefreshTokenUseCase = fetchRefreshTokenUseCase
    }
    
    func action(_ action: Action) {
        switch action {
        case .viewAppeared:
            Task {
                await fetchDiverCollectionRate()
                await fetchAllDiverList()
                await fetchDiverCollection()
            }
            
        case .profileSettingButtonTapped:
            print("profile setting button tapped!")
        case .diverTapped:
            print("diver tapped!")
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
            state.errorMessage = "도감 달성률 조회에 실패하였습니다."
            state.isErrorShowing = true
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
            state.errorMessage = "도감 유저 리스트 조회에 실패하였습니다."
            state.isErrorShowing = true
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
                state.isFoundedDiver[diverProfile.id] = true
            }
            print(diverProfiles)
        case .failure:
            state.errorMessage = "도감 사용자 리스트 조회에 실패하였습니다."
            state.isErrorShowing = true
        }
    }
}
