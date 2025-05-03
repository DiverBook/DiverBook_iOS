//
//  DiverSearchResultViewModel.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/22/25.
//

import Combine
import SwiftUI

final class DiverSearchResultViewModel: ViewModelable {
    struct State {
        var diverInfo: DiverProfile?
        var errorMessage: String?
    }
    
    enum Action {
        case startConversation
        case loadDiverProfile(id: String)
    }
    
    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator
    
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
    }
    
    func action(_ action: Action) {
        switch action {
        case .startConversation:
            coordinator.push(.startConversation)
        case .loadDiverProfile(let id):
            Task {
                await loadDiverProfileData(id: id)
            }
        }
    }
    
    private func loadDiverProfileData(id: String) async {
        async let infoResult = TokenRefreshHandler.withTokenRefresh(
            operation: { await self.fetchDiverProfileUseCase.executeFetchProfile(id: id) },
            refreshTokenUseCase: fetchRefreshTokenUseCase)
        
        let diverInfoResult = await infoResult
        
        switch diverInfoResult {
        case .success(let info):
            state.diverInfo = info
        case .failure(let error):
            print("Failed to fetch diver info: \(error)")
        }
    }
}
