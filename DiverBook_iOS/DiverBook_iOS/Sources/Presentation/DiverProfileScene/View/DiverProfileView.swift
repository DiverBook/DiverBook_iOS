//
//  ProfileView.swift
//  DiverBook_iOS
//
//  Created by bear on 4/17/25.
//

import SwiftUI

struct DiverProfileView: View {
    @StateObject private var viewModel: DiverProfileViewModel
    
    init(coordinator: Coordinator, diverId: String) {
        let fetchDiverProfileUseCase = DefaultFetchDiverProfileUseCase(
            repository: DefaultDiverRepository(
                diverProfileService: DiverProfileService()
            )
        )
        
        let fetchDiverCollectionUsecase = DefaultDiverCollectionUseCase(diverCollectionRepository: DefaultDiverCollectionRepository(diverCollectionService: DiverCollectionService()))
        
        let updateDiverMemoUseCase = DefaultUpdateDiverMemoUseCase(diverCollectionRepository: DefaultDiverCollectionRepository(diverCollectionService: DiverCollectionService()))
        
        _viewModel = StateObject(
            wrappedValue: DiverProfileViewModel(
                fetchDiverProfileUseCase: fetchDiverProfileUseCase,
                fetchDIverCollectionUseCase: fetchDiverCollectionUsecase,
                updateDiverMemoUseCase: updateDiverMemoUseCase,
                diverId: diverId
            )
        )
    }
    
    // profileContent extracted to DiverProfileContentView below
    
    var body: some View {
        VStack {
            DiverProfileTopBarView()
            
            if viewModel.state.isDataFetching {
                ScrollView(showsIndicators: false) {
                    DiverProfileContentView(
                        memo: $viewModel.memo, diverProfile: viewModel.state.diverProfile,
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
                        memo: $viewModel.memo, diverProfile: viewModel.state.diverProfile,
                        foundDate: viewModel.state.foundDate,
                        isSaveEnabled: viewModel.isSaveEnabled,
                        saveAction: {
                            viewModel.action(.saveMemo)
                        }
                    )
                }
            }
        }
        .padding(.horizontal, 24)
        .onAppear {
            viewModel.action(.viewAppeared)
        }
        
    }
}
