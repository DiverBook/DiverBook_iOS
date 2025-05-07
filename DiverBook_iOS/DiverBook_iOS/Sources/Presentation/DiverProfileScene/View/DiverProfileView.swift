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
        _viewModel = StateObject(
            wrappedValue: DiverProfileViewModel(
                fetchDiverProfileUseCase: fetchDiverProfileUseCase,
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
                        diverProfile: viewModel.state.diverProfile,
                        history: $viewModel.history,
                        isSaveEnabled: viewModel.isSaveEnabled,
                        saveAction: {
                            // 저장 액션 처리 예정
                        }
                    )
                }
                .redacted(reason: .placeholder)
            } else {
                ScrollView(showsIndicators: false) {
                    DiverProfileContentView(
                        diverProfile: viewModel.state.diverProfile,
                        history: $viewModel.history,
                        isSaveEnabled: viewModel.isSaveEnabled,
                        saveAction: {
                            // 저장 액션 처리 예정
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


