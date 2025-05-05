//
//  DiverProfileViewModel.swift
//  DiverBook_iOS
//
//  Created by jun on 4/27/25.
//

import Combine
import Foundation

final class DiverProfileViewModel: ViewModelable {
    struct State {
        var profileImageURL: URL?
        var name: String = ""
        var foundDate: String = ""
        var todayTalk: String = ""
        var division: String = ""
        var phoneNumber: String = ""
        var interests: String = ""
        var places: String = ""
    }

    enum Action {
        case fetchDiverProfile
        case updateHistory(String)
    }

    @Published var state = State()

    @Published var history: String = ""
    private var originalHistory: String = ""

    @Published private(set) var isSaveEnabled: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        action(.fetchDiverProfile)
        observeHistoryChanges()
    }

    func action(_ action: Action) {
        switch action {
        case .fetchDiverProfile:
            fetchDiverProfile()

        case .updateHistory(let newHistory):
            history = newHistory
        }
    }

    private func fetchDiverProfile() {
        self.state = State(
            profileImageURL: DiverProfile.mockData.profileImageUrl,
            name: DiverProfile.mockData.userName,
            foundDate: "25.03.24",
            todayTalk: DiverProfile.mockData.about,
            division: DiverProfile.mockData.divisions,
            phoneNumber: DiverProfile.mockData.phoneNumber,
            interests: DiverProfile.mockData.interests,
            places: DiverProfile.mockData.places
        )
        self.history = "처음 만난 날 기억나니?"
        self.originalHistory = history
    }

    private func observeHistoryChanges() {
        $history
            .map { [weak self] newHistory in
                return newHistory != self?.originalHistory
            }
            .removeDuplicates()
            .sink { [weak self] isChanged in
                self?.isSaveEnabled = isChanged
            }
            .store(in: &cancellables)
    }
}
