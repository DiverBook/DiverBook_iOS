//
//  ProfileView.swift
//  DiverBook_iOS
//
//  Created by bear on 4/17/25.
//

import SwiftUI

struct DiverProfileView: View {
    @GestureState private var dragOffset: CGSize = .zero
    @FocusState var memoFocused: Bool
    @Environment(\.dismiss) var dismiss
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

        let postUserBadgeUseCase = DefaultPostUserBadgeUseCase(
            badgeRepository: DefaultBadgeRepository(
                badgeService: CollectedBadgeService()
            )
        )

        _viewModel = StateObject(
            wrappedValue: DiverProfileViewModel(
                coordinator: coordinator,
                mode: mode,
                fetchDiverProfileUseCase: fetchDiverProfileUseCase,
                fetchDIverCollectionUseCase: fetchDiverCollectionUsecase,
                updateDiverMemoUseCase: updateDiverMemoUseCase,
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
                            memoFocused: _memoFocused,
                            diverProfile: viewModel.state.diverProfile,
                            foundDate: viewModel.state.foundDate,
                            isSaveEnabled: viewModel.isSaveEnabled,
                            saveAction: {
                                viewModel.action(.saveMemo)
                            }
                        )
                        Spacer()
                            .frame(height: 1)
                    }
                    .onChange(of: memoFocused) {
                        if memoFocused {
                            Task {
                                try await Task.sleep(nanoseconds: 300_000_000)
                                await MainActor.run {
                                    withAnimation {
                                        proxy.scrollTo("bottom")
                                    }
                                }
                            }
                        }
                    }
//                    .safeAreaInset(edge: .bottom) {
//                        Color.clear
//                            .frame(
//                                height: max(
//                                    0,
//                                    keyboardObserver.keyboardHeight - 50
//                                )
//                            )
//                    }
//                    .animation(
//                        .easeOut(duration: 0.1),
//                        value: keyboardObserver.keyboardHeight
//                    )
                }
            }
        }
        .setBackGesture(dragOffset: $dragOffset, dismiss: { dismiss() })
        .padding(.horizontal, 24)
        .onAppear {
            viewModel.action(.viewAppeared)
        }
        .onChange(of: viewModel.memo) { newValue in
            viewModel.action(.memoChanged(newValue))
        }
        .hideKeyboardOnTap()
    }
}
