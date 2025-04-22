//
//  DiverSearchResultView.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/21/25.
//

import SwiftUI

struct DiverSearchResultView: View {
    let nickname: String
    
    var body: some View {
        VStack {
            Spacer()
            Group {
                Text("심해를 탐험하는")
                    .foregroundColor(DiveColor.gray4)
                Text("\(nickname) ")
                    .foregroundColor(DiveColor.color6)
                + Text("발견!")
                    .foregroundColor(DiveColor.gray4)
            }
            .font(DiveFont.headingH1)
            
            PrimaryProfile(image: Image("exMemoji"), style: .found)
                .padding(.top, 20)
            Spacer()
            PrimaryButton(title: "대화 시작", coordinator: Coordinator()) {
                // TODO: - 대화 시작으로 이동
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    DiverSearchResultView(nickname: "Berry")
}
