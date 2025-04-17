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
            // MARK: 추후 버튼 컴포넌트 사용하도록 수정
            Spacer()
            Button(action: {
                self.viewModel.action(.signUpButtonTapped)
            }) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue)
                    .frame(height: 55)
                    .overlay(
                        Text("등록하기")
                            .font(.callout)
                            .foregroundStyle(.white)
                    )
            }
            .padding(.bottom, 50)
        }
    }
}
