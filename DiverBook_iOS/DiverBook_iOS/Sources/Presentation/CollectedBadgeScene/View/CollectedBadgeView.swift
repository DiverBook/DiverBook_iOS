//
//  CollectedBadgeView.swift
//  DiverBook_iOS
//
//  Created by jun on 4/26/25.
//

import SwiftUI

struct CollectedBadgeView: View {
    @ObservedObject private var viewModel = CollectedBadgeViewModel(
        registeredDiverCount: 17
    )

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.badges) { badge in
                    BadgeCardView(badge: badge)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    CollectedBadgeView()
}

#Preview {
    CollectedBadgeView()
}
