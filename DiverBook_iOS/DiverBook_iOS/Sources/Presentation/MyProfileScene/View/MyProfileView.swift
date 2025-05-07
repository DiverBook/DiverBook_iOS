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
        VStack{
            MyProfileTopBarView()
            
            if viewModel.state.isDataFetching {
                ScrollView(showsIndicators: false){
                    VStack(spacing: 8) {
                        PrimaryProfile(
                            imageURL: viewModel.state.myProfile
                                .profileImageUrl,
                            style: .mypage
                        )
                        
                        Text(viewModel.state.myProfile.userName)
                            .font(DiveFont.headingH3)
                        
                        TodayTalkSectionView(
                            mode: .editable(
                                binding: $viewModel.state.myProfile.about
                            )
                        )
                        
                        Spacer().frame(height: 40)
                        
                        ProfileDetailsInfoView(
                            division: .editable(
                                binding: $viewModel.state.myProfile.divisions
                            ),
                            phoneNumber: .editable(
                                binding: $viewModel.state.myProfile.phoneNumber
                            ),
                            interests: .editable(
                                binding: $viewModel.state.myProfile.interests
                            ),
                            places: .editable(
                                binding: $viewModel.state.myProfile.places
                            )
                        )
                        
                        Spacer().frame(height: 10)
                        
                        CollectedBadgeButtonView(
                            badgeCount: viewModel.state.badgeCount
                        )
                        
                        Spacer()
                    }
                }
                .redacted(reason: .placeholder)
            } else {
                ScrollView(showsIndicators: false){
                    VStack(spacing: 8) {
                        PrimaryProfile(
                            imageURL: viewModel.state.myProfile
                                .profileImageUrl,
                            style: .mypage
                        )
                        
                        Text(viewModel.state.myProfile.userName)
                            .font(DiveFont.headingH3)
                        
                        TodayTalkSectionView(
                            mode: .editable(
                                binding: $viewModel.state.myProfile.about
                            )
                        )
                        
                        Spacer().frame(height: 40)
                        
                        ProfileDetailsInfoView(
                            division: .editable(
                                binding: $viewModel.state.myProfile.divisions
                            ),
                            phoneNumber: .editable(
                                binding: $viewModel.state.myProfile.phoneNumber
                            ),
                            interests: .editable(
                                binding: $viewModel.state.myProfile.interests
                            ),
                            places: .editable(
                                binding: $viewModel.state.myProfile.places
                            )
                        )
                        
                        Spacer().frame(height: 32)
                        
                        CollectedBadgeButtonView(
                            badgeCount: viewModel.state.badgeCount
                        )
                        
                        Spacer()
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .onAppear {
            viewModel.action(.viewAppeared)
        }
    }
}
