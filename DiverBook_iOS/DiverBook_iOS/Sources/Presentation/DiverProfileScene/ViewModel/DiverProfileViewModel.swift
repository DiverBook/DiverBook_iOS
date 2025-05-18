//
//  DiverProfileViewModel.swift
//  DiverBook_iOS
//
//  Created by jun on 4/27/25.
//

import Foundation

enum DiverProfileMode {
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
    @Published private(set) var isSaveEnabled: Bool = true

    private let coordinator: Coordinator
    private let mode: DiverProfileMode
    private var originalMemo: String = ""
    private let fetchDiverProfileUseCase: FetchDiverProfileUseCase
    private let fetchDiverCollectionUseCase: DiverCollectionUseCase
    private let updateDiverMemoUseCase: UpdateDiverMemoUseCase
    private let postUserBadgeUseCase: PostUserBadgeUseCase
    private let saveDiverMemoUseCase: SaveDiverMemoUseCase

    init(
        coordinator: Coordinator,
        mode: DiverProfileMode,
        fetchDiverProfileUseCase: FetchDiverProfileUseCase,
        fetchDIverCollectionUseCase: DiverCollectionUseCase,
        updateDiverMemoUseCase: UpdateDiverMemoUseCase,
        postUserBadgeUseCase: PostUserBadgeUseCase,
        saveDiverMemoUseCase: SaveDiverMemoUseCase,
        diverId: String
    ) {
        self.coordinator = coordinator
        self.mode = mode
        self.fetchDiverProfileUseCase = fetchDiverProfileUseCase
        self.fetchDiverCollectionUseCase = fetchDIverCollectionUseCase
        self.updateDiverMemoUseCase = updateDiverMemoUseCase
        self.postUserBadgeUseCase = postUserBadgeUseCase
        self.saveDiverMemoUseCase = saveDiverMemoUseCase
        self.state.diverId = diverId
    }

    func action(_ action: Action) {
        switch action {
        case .viewAppeared:
            Task {
                await MainActor.run {
                    state.isDataFetching = true
                }

                await fetchDiverProfileById()
                await fetchDiverCollectionInfo()

                await MainActor.run {
                    state.isDataFetching = false
                }
            }

        case .memoChanged(let newMemo):
            memo = newMemo

        case .saveMemo:
            Task {
                await saveMemo()
            }
        }
    }

    private func fetchDiverProfileById() async {
        let result = await fetchDiverProfileUseCase.executeFetchProfile(
            id: state.diverId
        )

        await MainActor.run {
            switch result {
            case .success(let profile):
                state.diverProfile = profile
            case .failure(let error):
                print("❌ 다이버 프로필 조회 실패: \(error)")
            }

            state.isDataFetching = false
        }
    }

    private func fetchDiverCollectionInfo() async {
        let result =
            await fetchDiverCollectionUseCase.executeFetchDiverCollection()

        await MainActor.run {
            switch result {
            case .success(let collection):
                if let diverInfo = collection.first(where: {
                    $0.foundUserId == state.diverId
                }) {
                    state.foundDate = DateFormatterUtil.formatFoundDate(
                        diverInfo.foundDate
                    )
                    memo = diverInfo.memo
                    originalMemo = diverInfo.memo
                } else if mode == .create {
                    state.foundDate = DateFormatterUtil.formatToday()
                }

            case .failure(let error):
                print("다이버 도감 정보 조회 실패: \(error))")
            }
        }
    }

    private func createDiverMemo() async {
        let createResult =
            await saveDiverMemoUseCase.executeSaveDiverMemoUseCase(
                foundUserId: state.diverId,
                memo: memo
            )

        switch createResult {
        case .success(let updated):
            print("✅ 메모 POST 성공")

            async let collectedResult =
                fetchDiverCollectionUseCase.executeFetchDiverCollection()
            async let allDiverResult =
                fetchDiverCollectionUseCase.executeFetchAllDiverList()

            do {
                let collections = try await collectedResult.get()
                let allDivers = try await allDiverResult.get()
                let collectedCount = collections.count
                let totalCount = allDivers.count

                if let badgeCode = badgeCodeForCollectionCount(
                    collectedCount,
                    totalCount: totalCount
                ) {
                    do {
                        let collectedBadge =
                            try await postUserBadgeUseCase.executePostUserBadge(
                                badgeCode: badgeCode
                            )
                        await MainActor.run {
                            coordinator.path = [
                                .badgeReward(
                                    badgeCode: collectedBadge.badgeCode
                                )
                            ]
                        }
                        return
                    } catch {
                        print("❌ 뱃지 POST 실패: \(error.localizedDescription)")
                    }
                } else {
                    print("⚠️ 뱃지 조건 불충족")
                }
            } catch {
                print("❌ 도감 조회 실패: \(error.localizedDescription)")
            }

            await MainActor.run {
                coordinator.path = [.mainTab]
            }

        case .failure(let error):
            print("❌ POST 실패: \(error)")
        }
    }

    private func updateDiverMemo() async {
        let result = await updateDiverMemoUseCase.executeUpdateDiverMemoUseCase(
            foundUserId: state.diverId,
            memo: memo
        )

        switch result {
        case .success:
            await MainActor.run {
                coordinator.pop()
            }
            print("✅ PATCH 성공")

        case .failure(let error):
            await MainActor.run {
                print("❌ PATCH 실패: \(error)")
            }
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

    private func badgeCodeForCollectionCount(
        _ collectedCount: Int,
        totalCount: Int
    ) -> String? {
        switch collectedCount {
        case 1: return "B001"
        case 10: return "B002"
        case 20: return "B003"
        case 30: return "B004"
        case 40: return "B005"
        case 50: return "B006"
        case 60: return "B007"
        case _ where collectedCount == totalCount: return "B008"
        default: return nil
        }
    }
}
