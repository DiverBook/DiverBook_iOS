//
//  CheckConversationViewModel.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/17/25.
//

import Combine
import SwiftUI

final class CheckConversationViewModel: ViewModelable {
    struct State {
    }
    
    enum Action {
        case sendFinishConversation
        case checkFinishConversation(isFinishConversation: String)
    }
    
    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator
    
    private let userID: String
    private let diverId: String
    private let saveDiverMemoUseCase: SaveDiverMemoUseCase
    private lazy var dataTransferManager: DataTransferManager = {
        return DataTransferManager(userID: userID, viewModel: self)
    }()
    
    init(
        coordinator: Coordinator,
        diverId: String,
        saveDiverMemoUseCase: SaveDiverMemoUseCase
    ) {
        self.userID = UserToken.id
        self.diverId = diverId
        self.coordinator = coordinator
        self.saveDiverMemoUseCase = saveDiverMemoUseCase
        dataTransferManager.currentMode = .checkConversation
    }
    
    func action(_ action: Action) {
        switch action {
        case .sendFinishConversation:
            dataTransferManager.startSession()
        case .checkFinishConversation(let flag):
            checkFinishFlag(isFinishFlag: flag)
        }
    }
    
    func stopSearching() {
        dataTransferManager.stopSession()
    }
    
    private func checkFinishFlag(isFinishFlag: String) {
        if isFinishFlag == "finish" {
            Task {
                await createDiverMemo()
                coordinator.push(.finishConversation(id: diverId))
            }
        }
    }
    
    private func createDiverMemo() async {
        let createResult = await saveDiverMemoUseCase.executeSaveDiverMemoUseCase(
            foundUserId: diverId,
            memo: ""
        )

        switch createResult {
        case .success(let updated):
            print("✅ 새로운 도감 정보 저장 성공")
            LocalUserData.hasNewDiverProfile = true
            await MainActor.run {
                coordinator.path = [.mainTab]
            }

        case .failure(let error):
            print("❌ 새로운 도감 정보 저장 실패: \(error)")
        }
    }

}
