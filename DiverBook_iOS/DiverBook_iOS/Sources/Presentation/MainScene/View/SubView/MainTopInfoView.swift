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
            MainDiverInfoView(viewModel: self.viewModel)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            UserBookSuccessRateView(viewModel: self.viewModel)
                .padding(.horizontal, 24)
        }
        .padding(.horizontal, 13)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(DiveColor.color6)
                .frame(width: UIScreen.main.bounds.width - 24, height: 270)
        )
    }
}
