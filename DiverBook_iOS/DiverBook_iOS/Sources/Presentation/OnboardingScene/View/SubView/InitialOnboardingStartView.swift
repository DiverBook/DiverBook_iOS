//
//  InitialOnboarding.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/1/25.
//

import SwiftUI

struct InitialOnboardingStartView: View {
    
    private var startButtonTapAction: () -> Void
    
    init(startButtonTapAction: @escaping () -> Void) {
        self.startButtonTapAction = startButtonTapAction
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("initialOnboardingStart")
                .resizable()
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height
                )
            Button(action: {
                startButtonTapAction()
            }, label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width: UIScreen.main.bounds.width - 48, height: 55)
                    .overlay(
                        Text("시작하기")
                            .font(DiveFont.button)
                            .foregroundStyle(DiveColor.color6)
                    )
            })
            .buttonStyle(.plain)
            .padding(.bottom, 52)
        }
    }
}
