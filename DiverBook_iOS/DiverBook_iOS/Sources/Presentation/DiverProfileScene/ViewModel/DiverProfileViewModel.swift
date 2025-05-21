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

    init(
        coordinator: Coordinator,
        mode: DiverProfileMode,
        fetchDiverProfileUseCase: FetchDiverProfileUseCase,
        fetchDIverCollectionUseCase: DiverCollectionUseCase,
        updateDiverMemoUseCase: UpdateDiverMemoUseCase,
        postUserBadgeUseCase: PostUserBadgeUseCase,
        diverId: String
    ) {
        self.coordinator = coordinator
        self.mode = mode
        self.fetchDiverProfileUseCase = fetchDiverProfileUseCase
        self.fetchDiverCollectionUseCase = fetchDIverCollectionUseCase
        self.updateDiverMemoUseCase = updateDiverMemoUseCase
        self.postUserBadgeUseCase = postUserBadgeUseCase
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
        let createResult = await updateDiverMemoUseCase.executeUpdateDiverMemoUseCase(
            foundUserId: state.diverId,
            memo: memo
        )

        switch createResult {
        case .success(let updated):
            print("✅ [Memo POST] 메모 저장 성공: \(updated.memo)")
            
            if mode == .create {
                print("🔁 [Mode Check] 현재 모드는 .create입니다. 뱃지 획득 조건 확인을 시작합니다.")
                
                async let collectedResult = fetchDiverCollectionUseCase.executeFetchDiverCollection()
                async let allDiverResult = fetchDiverCollectionUseCase.executeFetchAllDiverList()

                do {
                    let collections = try await collectedResult.get()
                    let allDivers = try await allDiverResult.get()
                    let collectedCount = collections.count
                    let totalCount = allDivers.count
                    
                    print("📦 [도감 수] 수집된 다이버 수: \(collectedCount)")
                    print("📦 [전체 수] 전체 다이버 수: \(totalCount)")

                    if let badgeCode = badgeCodeForCollectionCount(collectedCount, totalCount: totalCount) {
                        print("🏷️ [Badge 조건 충족] 획득 가능한 뱃지 코드: \(badgeCode)")

                        do {
                            let collectedBadge = try await postUserBadgeUseCase.executePostUserBadge(badgeCode: badgeCode)
                            print("🎉 [Badge POST] 서버에 뱃지 POST 성공 - 코드: \(collectedBadge.badgeCode)")

                            await MainActor.run {
                                print("➡️ [Navigation] BadgeRewardView로 이동")
                                coordinator.path = [.badgeReward(badgeCode: collectedBadge.badgeCode)]
                            }
                            return
                        } catch {
                            print("❌ [Badge POST 실패] \(error.localizedDescription)")
                        }
                    } else {
                        print("⚠️ [Badge 조건 미충족] 조건에 맞는 뱃지 없음")
                    }

                } catch {
                    print("❌ [도감 조회 실패] \(error.localizedDescription)")
                }
            } else {
                print("📴 [Mode] 현재 모드는 .edit이므로 뱃지 획득 로직은 실행되지 않습니다.")
            }

            await MainActor.run {
                print("➡️ [Navigation] 메인탭으로 이동")
                coordinator.path = [.mainTab]
            }

        case .failure(let error):
            print("❌ [Memo POST 실패] \(error.localizedDescription)")
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
        case 100: return "B007"
        case _ where collectedCount == totalCount: return "B008"
        default: return nil
        }
    }
}
