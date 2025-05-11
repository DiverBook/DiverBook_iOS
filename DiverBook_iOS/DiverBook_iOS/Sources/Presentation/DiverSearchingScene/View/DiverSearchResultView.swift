//
//  DiverSearchResultView.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/21/25.
//

import SwiftUI

struct DiverSearchResultView: View {
    @StateObject var viewModel: DiverSearchResultViewModel
        
    let diverProfile: DiverProfile

    init(diverProfile: DiverProfile, coordinator: Coordinator) {
        self.diverProfile = diverProfile
        _viewModel = StateObject(
            wrappedValue: DiverSearchResultViewModel(
                coordinator: coordinator
            )
        )
    }
    
    var body: some View {
        VStack {
            TopBar()
            Spacer()
            Group {
                Text("심해를 탐험하는")
                    .foregroundColor(DiveColor.gray4)
                Text("\(diverProfile.userName) ")
                    .foregroundColor(DiveColor.color6)
                + Text("발견!")
                    .foregroundColor(DiveColor.gray4)
            }
            .font(DiveFont.headingH1)
            
            PrimaryProfile(imageURL: diverProfile.profileImageUrl, style: .found)
                    .padding(.top, 20)
            
            Spacer()
            PrimaryButton(title: "대화 시작", coordinator: Coordinator()) {
                viewModel.action(.startConversation(diverId: diverProfile.id))
            }
        }
        .padding(.horizontal, 24)
    }
}
