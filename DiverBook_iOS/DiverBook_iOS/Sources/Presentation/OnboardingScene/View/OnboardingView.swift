//
//  OnboardingView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/14/25.
//

import Combine
import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: OnboardingViewModel
    
    init(coordinator: Coordinator) {
        _viewModel = StateObject(wrappedValue: OnboardingViewModel(coordinator: coordinator))
    }

    var body: some View {
        ZStack {
            OnboardingContentView(viewModel: self.viewModel)
            .padding(.horizontal, 20)
            
            InitialOnboardingStartView(
                startButtonTapAction: {
                    viewModel.action(.initialStartButtonTapped)
                }
            )
            .opacity(viewModel.state.initialOnboardingEnd ? 0 : 1)
            .animation(.spring(), value: viewModel.state.initialOnboardingEnd)
            
            Image("splash").resizable().frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height)
            .opacity(self.viewModel.state.isSplashing ? 1 : 0)
            .animation(.spring(), value: self.viewModel.state.isSplashing)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.viewModel.action(.splashEnd)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    OnboardingView(coordinator: coordinator)
}
