//
//  ProfileView.swift
//  DiverBook_iOS
//
//  Created by bear on 4/17/25.
//

import SwiftUI

struct DiverProfileView: View {
    @StateObject private var viewModel: DiverProfileViewModel
    @StateObject private var keyboardObserver = KeyboardObserver()

    init(coordinator: Coordinator, diverId: String, mode: DiverProfileMode) {
        let fetchDiverProfileUseCase = DefaultFetchDiverProfileUseCase(
            repository: DefaultDiverRepository(
                diverProfileService: DiverProfileService()
            )
        )

        let fetchDiverCollectionUsecase = DefaultDiverCollectionUseCase(
            diverCollectionRepository: DefaultDiverCollectionRepository(
                diverCollectionService: DiverCollectionService()
            )
        )

        let updateDiverMemoUseCase = DefaultUpdateDiverMemoUseCase(
            diverCollectionRepository: DefaultDiverCollectionRepository(
                diverCollectionService: DiverCollectionService()
            )
        )
        
        let saveDiverMemoUseCase = DefaultSaveDiverMemoUseCase(
            diverCollectionRepository: DefaultDiverCollectionRepository(
                diverCollectionService: DiverCollectionService()
            )
        )
        
        let postUserBadgeUseCase = DefaultPostUserBadgeUseCase(badgeRepository: DefaultBadgeRepository(badgeService: CollectedBadgeService()))

        _viewModel = StateObject(
            wrappedValue: DiverProfileViewModel(
                coordinator: coordinator,
                mode: mode,
                fetchDiverProfileUseCase: fetchDiverProfileUseCase,
                fetchDIverCollectionUseCase: fetchDiverCollectionUsecase,
                updateDiverMemoUseCase: updateDiverMemoUseCase,
                saveDiverMemoUseCase: saveDiverMemoUseCase,
                postUserBadgeUseCase: postUserBadgeUseCase,
                diverId: diverId
            )
        )
    }

    var body: some View {
        VStack {
            DiverProfileTopBarView()

            if viewModel.state.isDataFetching {
                ScrollView(showsIndicators: false) {
                    DiverProfileContentView(
                        memo: $viewModel.memo,
                        diverProfile: viewModel.state.diverProfile,
                        foundDate: viewModel.state.foundDate,
                        isSaveEnabled: viewModel.isSaveEnabled,
                        saveAction: {
                            viewModel.action(.saveMemo)
                        }
                    )
                }
                .redacted(reason: .placeholder)
            } else {
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        DiverProfileContentView(
                            memo: $viewModel.memo,
                            diverProfile: viewModel.state.diverProfile,
                            foundDate: viewModel.state.foundDate,
                            isSaveEnabled: viewModel.isSaveEnabled,
                            saveAction: {
                                viewModel.action(.saveMemo)
                            }
                        )
                    }
                    .safeAreaInset(edge: .bottom) {
                        Color.clear
                            .frame(height: max(0, keyboardObserver.keyboardHeight - 50))
                    }
                    .animation(.easeOut(duration: 0.1), value: keyboardObserver.keyboardHeight)
                }
                .onChange(of: viewModel.memo) { newValue in
                    viewModel.action(.memoChanged(newValue))
                }
            }
        }
        .padding(.horizontal, 24)
        .onAppear {
            viewModel.action(.viewAppeared)
        }
        .hideKeyboardOnTap()
    }
}

import SwiftUI
import Combine

final class KeyboardObserver: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0

    private var cancellables = Set<AnyCancellable>()

    init() {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
            .map { $0.height }

        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        Publishers.Merge(willShow, willHide)
            .receive(on: RunLoop.main)
            .assign(to: \.keyboardHeight, on: self)
            .store(in: &cancellables)
    }
}
