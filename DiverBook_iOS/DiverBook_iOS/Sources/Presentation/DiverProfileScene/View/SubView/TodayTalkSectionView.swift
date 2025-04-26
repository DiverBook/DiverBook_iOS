//
//  TodayTalkSectionView.swift
//  DiverBook_iOS
//
//  Created by jun on 4/26/25.
//

import Foundation
import SwiftUI

struct TodayTalkSectionView: View {
    @Binding var todayTalk: String

    var body: some View {
        ZStack(alignment: .center) {
            Image("todayTalk")
                .resizable()
                .scaledToFill()
                .clipped()

            TextField("오늘의 한마디를 입력해주세요", text: $todayTalk)
                .font(DiveFont.bodyMedium2)
                .multilineTextAlignment(.center)
                .padding(16)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 55)
    }
}

#Preview {
    TodayTalkSectionView(todayTalk: .constant(""))
}
