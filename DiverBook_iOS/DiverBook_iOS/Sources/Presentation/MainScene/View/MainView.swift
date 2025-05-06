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
        ZStack {
            MainContentView(viewModel: viewModel)
            ServiceErrorAlert(
                message: viewModel.state.errorMessage,
                showErrorAlert: $viewModel.state.isErrorShowing
            )
        }
    }
}

#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    MainView(coordinator: coordinator)
}
