//
//  DiverProfileViewModel.swift
//  DiverBook_iOS
//
//  Created by jun on 4/27/25.
//

import Foundation

enum DiverProfileMode{
    case create
    case edit
}

final class DiverProfileViewModel: ViewModelable {
    struct State {
        var isDataFetching: Bool = false
        var diverProfile: DiverProfile = DiverProfile.unfoundMockData
        var diverId: String = ""
        var foundDate: String = ""
    }

    enum Action {
        case viewAppeared
        case memoChanged(String)
        case saveMemo
    }

    @Published var state = State()
    @Published var memo: String = ""
    @Published private(set) var isSaveEnabled: Bool = false
    
    private let coordinator: Coordinator
    private let mode: DiverProfileMode
    private var originalMemo: String = ""
    private let fetchDiverProfileUseCase: FetchDiverProfileUseCase
    private let fetchDiverCollectionUseCase: DiverCollectionUseCase
    private let updateDiverMemoUseCase: UpdateDiverMemoUseCase
    
    init(
        coordinator: Coordinator,
        mode: DiverProfileMode,
        fetchDiverProfileUseCase: FetchDiverProfileUseCase,
        fetchDIverCollectionUseCase: DiverCollectionUseCase,
        updateDiverMemoUseCase: UpdateDiverMemoUseCase,
        diverId: String
    ) {
        self.coordinator = coordinator
        self.mode = mode
        self.fetchDiverProfileUseCase = fetchDiverProfileUseCase
        self.fetchDiverCollectionUseCase = fetchDIverCollectionUseCase
        self.updateDiverMemoUseCase = updateDiverMemoUseCase
        self.state.diverId = diverId
    }

    func action(_ action: Action) {
        switch action {
        case .viewAppeared:
            state.isDataFetching = true
            Task {
                await fetchDiverProfileById()
                await fetchDiverCollectionInfo()
                state.isDataFetching = false
            }

        case .memoChanged(let newMemo):
            memo = newMemo
            isSaveEnabled = (memo != originalMemo)

        case .saveMemo:
            Task {
                await saveMemo()
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
    
    private func fetchDiverCollectionInfo() async {
        let result = await fetchDiverCollectionUseCase.executeFetchDiverCollection()
        switch result {
        case .success(let collection):
            if let diverInfo = collection.first(where: { $0.foundUserId == state.diverId }) {
                state.foundDate = diverInfo.foundDate
                memo = diverInfo.memo
                originalMemo = diverInfo.memo
                isSaveEnabled = false
            }
        case .failure(let error):
            print("다이버 도감 정보 조회 실패: \(error))")
        }
        
        state.isDataFetching = false
    }
    
    private func createDiverMemo() async {
        // TODO: POST로 첫 메모 작성하기
        print("메모 최초 등록")
    }

    private func updateDiverMemo() async {
        let result = await updateDiverMemoUseCase.executeUpdateDiverMemoUseCase(
            foundUserId: state.diverId,
            memo: memo
        )

        switch result {
        case .success(let updated):
            originalMemo = updated.memo
            isSaveEnabled = false
            coordinator.pop()
            print("✅ PATCH 성공")
        case .failure(let error):
            print("❌ PATCH 실패: \(error)")
        }
    }
    
    private func saveMemo() async {
        switch mode {
        case .create:
            await createDiverMemo()

        case .edit:
            await updateDiverMemo()
        }
    }
}
