//
//  UserBookSuccessRateView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/23/25.
//

import Combine
import SwiftUI

struct UserBookSuccessRateView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeadingText(text: "도감 달성률")
                .font(DiveFont.bodySmallPretendard)
                .padding(.bottom, 6)
            DiveRateBar(
                rate: self.$viewModel.state.bookAttainmentRate
            )
            .padding(.bottom, 10)
            Text("다이버를 찾아 도감을 완성해보세요")
                .font(DiveFont.bodyExtra1)
        }
        .frame(width: UIScreen.main.bounds.width - 92)
        .padding(.all, 20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white.opacity(0.9))
        )
    }
}

//#Preview {
//    @Previewable @StateObject var coordinator = Coordinator()
//    @Previewable @State var rate: Double = 50
//    UserBookSuccessRateView(viewModel: MainViewModel(coordinator: coordinator))
//}
