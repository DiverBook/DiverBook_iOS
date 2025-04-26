//
//  MainTopInfoView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/23/25.
//

import Combine
import SwiftUI

struct MainTopInfoView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeadingText(text: "다이버 도감")
                .font(DiveFont.title2Emphasized)
                .foregroundStyle(.white)
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
                .padding(.top, 70)
            MainDiverInfoView(viewModel: self.viewModel)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            UserBookSuccessRateView(viewModel: self.viewModel)
                .padding(.horizontal, 24)
                .padding(.bottom, 31)
        }
    }
}
