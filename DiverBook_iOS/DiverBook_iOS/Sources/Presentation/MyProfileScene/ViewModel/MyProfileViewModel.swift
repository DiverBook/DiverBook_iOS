//
//  MyProfileViewModel.swift
//  DiverBook_iOS
//
//  Created by jun on 4/27/25.
//

import Combine
import Foundation
import SwiftUI

final class MyProfileViewModel: ViewModelable {
    struct State {
        var isDataFetching: Bool = false
        var myProfile: DiverProfile = DiverProfile.mockData

        var todayTalk: String = ""
        var division: String = ""
        var phoneNumber: String = ""
        var interests: String = ""
        var places: String = ""
        var badgeCount: Int = 0

        var errorMessage: String = ""
        var isErrorShowing: Bool = false
    }

    enum Action {
        case viewAppeared
        case tapCollectedBadge
    }

    @Published var state = State()
    @ObservedObject var coordinator: Coordinator

    private var cancellables = Set<AnyCancellable>()

    // UseCases
    private let fetchDiverProfileUseCase: FetchDiverProfileUseCase
    private let fetchRefreshTokenUseCase: FetchRefreshTokenUseCase
    private var updateMyProfileUseCase: UpdateMyProfileUseCase
    private let fetchBadgeUseCase: FetchBadgesUseCase

    init(
        coordinator: Coordinator,
        fetchDiverProfileUseCase: FetchDiverProfileUseCase,
        fetchRefreshTokenUseCase: FetchRefreshTokenUseCase,
        updateMyProfileUseCase: UpdateMyProfileUseCase,
        fetchBadgeUseCase: FetchBadgesUseCase
    ) {
        self.coordinator = coordinator
        self.fetchDiverProfileUseCase = fetchDiverProfileUseCase
        self.fetchRefreshTokenUseCase = fetchRefreshTokenUseCase
        self.updateMyProfileUseCase = updateMyProfileUseCase
        self.fetchBadgeUseCase = fetchBadgeUseCase
        observeStateChanges()
    }

    func action(_ action: Action) {
        switch action {
        case .viewAppeared:
            state.isDataFetching = true
            Task {
                await fetchMyProfile()
                state.isDataFetching = false
            }
        case .tapCollectedBadge:
            coordinator.push(.collectedBadge)
        }
    }

    private func fetchMyProfile() async {
        let myProfileResult = await TokenRefreshHandler.withTokenRefresh(
            operation: {
                await self.fetchDiverProfileUseCase.executeFetchMyProfile()
            },
            refreshTokenUseCase: fetchRefreshTokenUseCase
        )

        switch myProfileResult {
        case .success(let profile):
            state.myProfile = profile
            state.todayTalk = profile.about
            state.division = profile.divisions
            state.phoneNumber = profile.phoneNumber
            state.interests = profile.interests
            state.places = profile.places
            
            await fetchBadgeCount()
        case .failure:
            activateErrorAlert(message: "사용자 정보 조회에 실패하였습니다.")
        }
    }

    private func observeStateChanges() {
        $state
            .dropFirst()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateProfile()
            }
            .store(in: &cancellables)
    }

    private func updateProfile() {
        Task {
            let result = await updateMyProfileUseCase.execute(
                divisions: state.division,
                phoneNumber: state.phoneNumber,
                interests: state.interests,
                places: state.places,
                about: state.todayTalk
            )

            switch result {
            case .success:
                print("✅ 프로필 업데이트 성공")
            case .failure(let error):
                print("❌ 프로필 업데이트 실패: \(error)")
            }
        }
    }
    
    private func fetchBadgeCount() async {
        do {
            let collectedBadgeCodes = try await fetchBadgeUseCase.executeFetchBadges()
            await MainActor.run {
                state.badgeCount = collectedBadgeCodes.count
            }
        } catch {
            print("❌ 뱃지 수 불러오기 실패: \(error)")
        }
    }

    private func activateErrorAlert(message: String) {
        state.errorMessage = message
        state.isErrorShowing = true
    }
}
