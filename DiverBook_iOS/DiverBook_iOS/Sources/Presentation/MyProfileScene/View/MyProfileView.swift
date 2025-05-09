//
//  MyProfileView.swift
//  DiverBook_iOS
//
//  Created by jun on 4/26/25.
//

import SwiftUI

struct MyProfileView: View {
    @StateObject private var viewModel: MyProfileViewModel
    
    init(coordinator: Coordinator) {
        let fetchDiverProfileUseCase = DefaultFetchDiverProfileUseCase(
            repository: DefaultDiverRepository(
                diverProfileService: DiverProfileService()
            )
        )
        
        let fetchRefreshTokenUseCase = DefaultFetchRefreshTokenUseCase(
            repository: DefaultAuthRepository(
                authService: DiverBookAuthService(),
                tokenService: DiverBookTokenService()
            )
        )
        
        _viewModel = StateObject(
            wrappedValue: MyProfileViewModel(
                coordinator: coordinator,
                fetchDiverProfileUseCase: fetchDiverProfileUseCase,
                fetchRefreshTokenUseCase: fetchRefreshTokenUseCase
            )
        )
    }
    
    var body: some View {
        VStack {
            MyProfileTopBarView()

            if viewModel.state.isDataFetching {
                ScrollView(showsIndicators: false) {
                    MyProfileContentView(
                        myProfile: $viewModel.state.myProfile,
                        badgeCount: viewModel.state.badgeCount,
                        onCollectedBadgeTap: {
                            viewModel.action(.tapCollectedBadge)
                        }
                    )
                }
                .redacted(reason: .placeholder)
            } else {
                ScrollView(showsIndicators: false) {
                    MyProfileContentView(
                        myProfile: $viewModel.state.myProfile,
                        badgeCount: viewModel.state.badgeCount,
                        onCollectedBadgeTap: {
                            viewModel.action(.tapCollectedBadge)
                        }
                    )
                }
            }
        }
        .padding(.horizontal, 20)
        .onAppear {
            viewModel.action(.viewAppeared)
        }
    }
}
