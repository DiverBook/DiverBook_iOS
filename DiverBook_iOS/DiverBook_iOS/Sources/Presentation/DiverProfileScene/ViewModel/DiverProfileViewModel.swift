//
//  DiverProfileViewModel.swift
//  DiverBook_iOS
//
//  Created by jun on 4/27/25.
//

import Foundation

final class DiverProfileViewModel: ViewModelable {
    struct State {
        var isDataFetching: Bool = false
        var diverProfile: DiverProfile = DiverProfile.unfoundMockData
        var diverId: String = ""
    }

    enum Action {
        case viewAppeared
    }

    @Published var state = State()
    
    @Published var history: String = ""
    @Published private(set) var isSaveEnabled: Bool = false
    
    private var originalHistory: String = ""
    
    private let fetchDiverProfileUseCase: FetchDiverProfileUseCase
    
    init(
        fetchDiverProfileUseCase: FetchDiverProfileUseCase,
        diverId: String
    ) {
        self.fetchDiverProfileUseCase = fetchDiverProfileUseCase
        self.state.diverId = diverId
    }

    func action(_ action: Action) {
        switch action {
        case .viewAppeared:
            state.isDataFetching = true
            Task {
                await fetchDiverProfileById()
            }
        }
    }
    
    private func fetchDiverProfileById() async {
        let result = await fetchDiverProfileUseCase.executeFetchProfile(id: state.diverId)
        
        switch result {
        case .success(let profile):
            state.diverProfile = profile
        case .failure(let error):
            print("❌ 다이버 프로필 조회 실패: \(error)")
        }
        
        state.isDataFetching = false
    }
}
