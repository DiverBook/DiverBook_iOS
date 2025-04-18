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
            PrimaryButton<EmptyView>(title: "등록하기", destination: nil) {
                self.viewModel.action(.signUpButtonTapped)
            }
            .padding(.bottom, 50)
        }
    }
}
