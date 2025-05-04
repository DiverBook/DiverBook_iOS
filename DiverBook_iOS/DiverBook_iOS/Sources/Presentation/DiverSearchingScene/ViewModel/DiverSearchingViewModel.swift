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
        case successSearchingDiver(diverID: String)
    }
    
    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator
    
    private let userID: String
    private lazy var dataTransferManager: DataTransferManager = {
        return DataTransferManager(userID: userID, viewModel: self)
    }()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        self.userID = UserToken.id
    }
    
    func action(_ action: Action) {
        switch action {
        case .successSearchingDiver(let diverID):
            self.coordinator.push(.searchResult(diverID: diverID))
        }
    }
    
    func startSearching() {
        dataTransferManager.startSession()
    }

    func stopSearching() {
        dataTransferManager.stopSession()
    }
}
