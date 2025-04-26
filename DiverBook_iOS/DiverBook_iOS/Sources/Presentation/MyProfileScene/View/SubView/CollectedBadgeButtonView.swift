//
//  CollectedBadgeButtonView.swift
//  DiverBook_iOS
//
//  Created by jun on 4/26/25.
//

import SwiftUI

struct CollectedBadgeButtonView: View {
    var badgeCount: Int
    
    var body: some View {
        Button(action: {
            print("수집한 뱃지 리스트 보기")
        }, label: {
            HStack {
                Text("수집한 뱃지")
                    .font(DiveFont.bodyLarge)
                    .foregroundStyle(DiveColor.gray3)
                
                Spacer()
                
                Text("\(badgeCount)개")
                    .font(DiveFont.bodyPretendard)
                    .foregroundStyle(DiveColor.black)
                
                Image(systemName: "chevron.right")
                    .font(DiveFont.bodyPretendard)
                    .foregroundStyle(DiveColor.color5)
            }
        })
    }
}

#Preview {
    CollectedBadgeButtonView(badgeCount: 5)
}
