//
//  DiverSearchResultView.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/21/25.
//

import SwiftUI

struct DiverSearchResultView: View {
    @StateObject var viewModel: DiverSearchResultViewModel
        
    let diverID: String

    init(diverID: String, coordinator: Coordinator) {
        self.diverID = diverID
        _viewModel = StateObject(
            wrappedValue: DiverSearchResultViewModel(
                coordinator: coordinator,
                fetchDiverProfileUseCase: DefaultFetchDiverProfileUseCase(
                    repository: DefaultDiverRepository(
                        diverProfileService: DiverProfileService()
                    )
                ), fetchRefreshTokenUseCase: DefaultFetchRefreshTokenUseCase(
                    repository: DefaultAuthRepository(
                        authService: DiverBookAuthService(),
                        tokenService: DiverBookTokenService()
                    )
                )
            )
        )
    }
    
    var body: some View {
        VStack {
            TopBar()
            Spacer()
            Group {
                Text("심해를 탐험하는")
                    .foregroundColor(DiveColor.gray4)
                if let diverInfo = viewModel.state.diverInfo {
                    Text("\(diverInfo.userName) ")
                        .foregroundColor(DiveColor.color6)
                    + Text("발견!")
                        .foregroundColor(DiveColor.gray4)
                }
            }
            .font(DiveFont.headingH1)
            
            if let diverImage = viewModel.state.diverInfo?.profileImageUrl {
                PrimaryProfile(imageURL: diverImage, style: .found)
                    .padding(.top, 20)
            }
            Spacer()
            PrimaryButton(title: "대화 시작", coordinator: Coordinator()) {
                viewModel.action(.startConversation)
            }
        }
        .padding(.horizontal, 24)
        .onAppear {
            viewModel.action(.loadDiverProfile(id: diverID))
        }
    }
}
