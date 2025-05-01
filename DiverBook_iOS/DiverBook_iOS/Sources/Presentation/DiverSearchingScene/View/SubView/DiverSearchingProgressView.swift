//
//  DiverSearchingProgressView.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/27/25.
//

import SwiftUI

struct DiverSearchingProgressView: View {
    var body: some View {
        HStack(spacing: 5) {
            ProgressView()
            Text("탐색중...")
                .font(DiveFont.bodyMedium2)
                .foregroundColor(DiveColor.gray3)
        }
        .padding(.top, 100)
    }
}
