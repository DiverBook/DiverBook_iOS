//
//  ProfileView.swift
//  DiverBook_iOS
//
//  Created by bear on 4/17/25.
//

import SwiftUI

struct DiverProfileView: View {
    @StateObject private var viewModel: DiverProfileViewModel

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
        
        let postUserBadgeUseCase = DefaultPostUserBadgeUseCase(badgeRepository: DefaultBadgeRepository(badgeService: BadgeService()))

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
