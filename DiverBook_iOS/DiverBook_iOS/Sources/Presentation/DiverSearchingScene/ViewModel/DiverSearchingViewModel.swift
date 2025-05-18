//
//  DiverSearchingViewModel.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/20/25.
//

import Combine
import SwiftUI

final class DiverSearchingViewModel: ViewModelable {
    struct State {
        var isFoundedDiver: [String] = []
    }
    
    enum Action {
        case successSearchingDiver(diverID: String)
    }
    
    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator
    
    private let userID: String
    private var diverProfile: DiverProfile
    private lazy var dataTransferManager: DataTransferManager = {
        return DataTransferManager(userID: userID, viewModel: self)
    }()
    private let fetchDiverProfileUseCase: FetchDiverProfileUseCase
    private let fetchRefreshTokenUseCase: FetchRefreshTokenUseCase
    private let collectionUseCase: DiverCollectionUseCase
    
    init(coordinator: Coordinator,
         fetchDiverProfileUseCase: FetchDiverProfileUseCase,
         fetchRefreshTokenUseCase: FetchRefreshTokenUseCase,
         collectionUseCase: DiverCollectionUseCase) {
        self.coordinator = coordinator
        self.userID = UserToken.id
        self.diverProfile = DiverProfile.mockData
        self.fetchDiverProfileUseCase = fetchDiverProfileUseCase
        self.fetchRefreshTokenUseCase = fetchRefreshTokenUseCase
        self.collectionUseCase = collectionUseCase
        dataTransferManager.currentMode = .diverSearch
    }
    
    func action(_ action: Action) {
        switch action {
        case .successSearchingDiver(let diverID):
            Task {
                await fetchDiverCollection()
                await loadDiverProfileData(id: diverID)
            }
        }
    }
    
    func startSearching() {
        dataTransferManager.startSession()
    }

    func stopSearching() {
        dataTransferManager.stopSession()
    }
    
    private func loadDiverProfileData(id: String) async {
        async let diverResult = TokenRefreshHandler.withTokenRefresh(
            operation: { await self.fetchDiverProfileUseCase.executeFetchProfile(id: id) },
            refreshTokenUseCase: fetchRefreshTokenUseCase)
        
        let result = await diverResult
        
        switch result {
        case .success(let info):
            diverProfile = info
            self.coordinator.push(
                .searchResult(
                    diverProfile: diverProfile,
                    hasBeenFound: state.isFoundedDiver.contains(id)
                )
            )
        case .failure(let error):
            print("Failed to fetch diver info: \(error)")
        }
    }
    
    private func fetchDiverCollection() async {
        let diverCollectionResult = await TokenRefreshHandler.withTokenRefresh(
            operation: {
                await self.collectionUseCase.executeFetchDiverCollection()
            },
            refreshTokenUseCase: fetchRefreshTokenUseCase
        )
        
        switch diverCollectionResult {
        case .success(let diverProfiles):
            for diverProfile in diverProfiles {
                state.isFoundedDiver.append(diverProfile.foundUserId)
            }
        case .failure(let error):
            print("Failed to fetch diver collections info: \(error)")
        }
    }
}
