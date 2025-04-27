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
    }
    
    enum Action {
        case successSearchingDiver(nickname: String)
    }
    
    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator
    
    private let nickname: String
    private lazy var dataTransferManager: DataTransferManager = {
        return DataTransferManager(nickname: nickname, viewModel: self)
    }()
    
    init(coordinator: Coordinator, nickname: String) {
        self.coordinator = coordinator
        self.nickname = nickname
    }
    
    func action(_ action: Action) {
        switch action {
        case .successSearchingDiver(let nickname):
            self.coordinator.push(.searchResult(nickname: nickname))
        }
    }
    
    func startSearching() {
        dataTransferManager.startSession()
    }

    func stopSearching() {
        dataTransferManager.stopSession()
    }
}
