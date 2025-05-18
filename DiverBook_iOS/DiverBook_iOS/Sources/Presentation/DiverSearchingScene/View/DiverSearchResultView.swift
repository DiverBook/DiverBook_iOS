//
//  DiverSearchResultView.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/21/25.
//

import SwiftUI

struct DiverSearchResultView: View {
    @StateObject var viewModel: DiverSearchResultViewModel
    @Environment(\.dismiss) var dismiss
        
    let diverProfile: DiverProfile
    let hasBeenFound: Bool

    init(diverProfile: DiverProfile,
         hasBeenFound: Bool,
         coordinator: Coordinator
    ) {
        self.diverProfile = diverProfile
        self.hasBeenFound = hasBeenFound
        _viewModel = StateObject(
            wrappedValue: DiverSearchResultViewModel(
                coordinator: coordinator
            )
        )
    }
    
    var body: some View {
        VStack {
            if hasBeenFound {
                XMarkBar(coordinator: viewModel.coordinator)
            } else {
                TopBar()
            }
            Spacer()
            Group {
                if hasBeenFound {
                    Text("함께 다이빙 했던")
                        .foregroundColor(DiveColor.gray4)
                    Text("\(diverProfile.userName) ")
                        .foregroundColor(DiveColor.color6)
                    + Text("발견!")
                        .foregroundColor(DiveColor.gray4)
                } else {
                    Text("심해를 탐험하는")
                        .foregroundColor(DiveColor.gray4)
                    Text("\(diverProfile.userName) ")
                        .foregroundColor(DiveColor.color6)
                    + Text("발견!")
                        .foregroundColor(DiveColor.gray4)
                }
            }
            .font(DiveFont.headingH1)
            
            PrimaryProfile(imageURL: diverProfile.profileImageUrl, style: .found)
                    .padding(.top, 20)
            
            Spacer()
            
            if hasBeenFound {
                PrimaryButton(title: "재탐색 하기", coordinator: Coordinator()) {
                    dismiss()
                }
            } else {
                PrimaryButton(title: "대화 시작", coordinator: Coordinator()) {
                    viewModel.action(.startConversation(diverId: diverProfile.id))
                }
            }
        }
        .padding(.horizontal, 24)
    }
}
