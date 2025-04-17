//
//  OnboardIntroView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/17/25.
//

import Combine
import SwiftUI

struct OnboardIntroView: View {
    @State var selectedTabIndex: Int = 0

    var body: some View {
        VStack {
            TabView(selection: self.$selectedTabIndex) {
                OnboardIntroContentView(
                    title: "다이빙을 함께할\n다이버를 찾아볼까요?", imageName: "intro1",
                    padding: 100
                )
                .tag(0)
                OnboardIntroContentView(
                    title: "다이버시티에 서식하는\n다이버 정보를 수집하고 확인해요",
                    imageName: "intro2",
                    padding: 30,
                    imagePadding: 90
                )
                .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(height: 500)
            Spacer().frame(height: 20)
            OnboardIntroIndicator(selectedTabIndex: self.$selectedTabIndex)
            
        }
    }
}

#Preview {
    OnboardIntroView()
}
