//
//  DiverCollectionListView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/23/25.
//

import Combine
import SwiftUI

struct DiverCollectionListView: View {
    @ObservedObject var viewModel: MainViewModel
    var diverTapAction: () -> Void
    
    init(
        viewModel: MainViewModel,
        diverTapAction: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.diverTapAction = diverTapAction
    }
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(minimum: 80, maximum: 200)),
            GridItem(.flexible(minimum: 80, maximum: 200)),
            GridItem(.flexible(minimum: 80, maximum: 200))
        ]) {
            ForEach(viewModel.state.diverProfiles, id: \.self) { diverProfile in
                PrimaryProfile(
                    imageURL: viewModel.state.isFoundedDiver[diverProfile.id] ?? false ? diverProfile.profileImageUrl : URL(string: ""),
                    nickname: diverProfile.userName,
                    style: .diver
                )
            }
        }
        .onAppear {
            viewModel.action(.viewAppeared)
        }
    }
}
