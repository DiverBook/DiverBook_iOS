//
//  CollectedBadgeView.swift
//  DiverBook_iOS
//
//  Created by jun on 4/26/25.
//

import SwiftUI

struct CollectedBadgeView: View {
    @StateObject private var viewModel: CollectedBadgeViewModel

    init() {
        let fetchBadgesUseCase = DefaultFetchBadgesUseCase(
            repository: DefaultBadgeRepository(
                badgeService: BadgeService()
            )
        )
        
        _viewModel = StateObject(
            wrappedValue: CollectedBadgeViewModel(
                fetchBadgesUseCase: fetchBadgesUseCase
            )
        )
    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        VStack {
            ZStack {
                TopBar()
                Text("수집한 뱃지")
                    .font(DiveFont.bar)
                    .foregroundColor(DiveColor.gray4)
            }
            .padding(.horizontal, 24)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.state.badges.sorted(by: { $0.code < $1.code }), id: \.code) { badge in
                        BadgeCardView(badge: badge)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }

        }
        .frame(maxHeight: .infinity)
    }
}
