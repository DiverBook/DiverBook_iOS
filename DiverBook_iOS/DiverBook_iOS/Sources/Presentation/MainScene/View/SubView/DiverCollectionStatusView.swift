//
//  DiverCollectionStatusView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/23/25.
//

import Combine
import SwiftUI

struct DiverCollectionStatusView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            LeadingText(text: "도감 현황")
                .font(DiveFont.headingH3)
                .padding(.vertical, 20)
                .padding(.horizontal, 38)
            
            DiverCollectionListView(
                viewModel: viewModel,
                diverTapAction: {
                self.viewModel.action(.diverTapped)
            })
        }
    }
}
