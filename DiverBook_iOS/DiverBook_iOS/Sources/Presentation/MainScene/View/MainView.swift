//
//  MainView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/7/25.
//
import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel
    
    init(coordinator: Coordinator) {
        let fetchDiverProfileUseCase = DefaultFetchDiverProfileUseCase(
            repository: DefaultDiverRepository(
                diverProfileService: DiverProfileService()
            )
        )
        
        let collectionRateUseCase = DefaultDiverCollectionRateUseCase(
            diverCollectionRateRepository: DefaultDiverCollectionRateRepository(
                diverCollectionRateService: DiverCollectionRateService()
            )
        )
        
        let collectionUseCase = DefaultDiverCollectionUseCase(
            diverCollectionRepository: DefaultDiverCollectionRepository(
                diverCollectionService: DiverCollectionService()
            )
        )
        
        let fetchRefreshTokenUseCase = DefaultFetchRefreshTokenUseCase(
            repository: DefaultAuthRepository(
                authService: DiverBookAuthService(),
                tokenService: DiverBookTokenService()
            )
        )
        
        self._viewModel = StateObject(
            wrappedValue: MainViewModel(
                coordinator: coordinator,
                fetchDiverProfileUseCase: fetchDiverProfileUseCase,
                collectionRateUseCase: collectionRateUseCase,
                collectionUseCase: collectionUseCase,
                fetchRefreshTokenUseCase: fetchRefreshTokenUseCase
            )
        )
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                if viewModel.state.isDataFetching {
                    VStack(spacing: 0) {
                        MainTopInfoView(viewModel: self.viewModel)
                            .background(DiveColor.color6)
                            .id("top")
                        DiverCollectionStatusView(viewModel: self.viewModel)
                            .padding(.bottom, 60)
                        Button(action: {
                            withAnimation {
                                proxy.scrollTo("top", anchor: .top)
                            }
                        }, label: {
                            HStack {
                                Image(systemName: "arrow.up")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 12)
                                Text("위로 가기")
                                    .font(.subheadline)
                            }
                        })
                        .padding(.bottom, 140)
                    }
                    .redacted(reason: .placeholder)
                }
                else {
                    VStack(spacing: 0) {
                        MainTopInfoView(viewModel: self.viewModel)
                            .background(DiveColor.color6)
                            .id("top")
                        DiverCollectionStatusView(viewModel: self.viewModel)
                            .padding(.bottom, 60)
                        Button(action: {
                            withAnimation {
                                proxy.scrollTo("top", anchor: .top)
                            }
                        }, label: {
                            HStack {
                                Image(systemName: "arrow.up")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 12)
                                Text("위로 가기")
                                    .font(.subheadline)
                            }
                        })
                        .padding(.bottom, 140)
                    }
                }
            }
            .ignoresSafeArea(edges: [.top])
        }
        .onAppear {
            viewModel.action(.viewAppeared)
        }
    }
}

#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    MainView(coordinator: coordinator)
}
