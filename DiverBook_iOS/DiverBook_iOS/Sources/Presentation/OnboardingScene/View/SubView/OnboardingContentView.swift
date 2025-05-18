//
//  OnboardingContentView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/17/25.
//

import Combine
import SwiftUI

struct OnboardingContentView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Spacer()
            OnboardIntroView()
            Spacer()
            PrimaryButton(title: "등록하기", coordinator: Coordinator()) {
                self.viewModel.action(.signUpButtonTapped)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 50)
        }
    }
}
