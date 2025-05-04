//
//  QuestionCardView.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/26/25.
//

import SwiftUI

struct QuestionCardFrontView: View {
    @Binding var degree: Double
    
    let index: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: CGFloat(18))
                .frame(width: 230, height: 300)
                .foregroundColor(DiveColor.white)
            VStack(alignment: .center) {
                Image("questioncardImageLogo")
                    .padding(.top, 60)
                    .padding(.bottom, 30)
                Divider()
                    .foregroundColor(DiveColor.gray1)
                    .padding(.bottom, 11)
                    .frame(width: 14)
                // TODO: - index 따라 데이터 사용으로 변경
                Text("지친 일상에서 가장 힘이 되는 것은 무엇인가요?")
                    .multilineTextAlignment(.center)
                    .frame(width: 180)
                    .font(DiveFont.bodyPretendard)
                    .foregroundColor(DiveColor.gray4)
                Spacer()
                Image("questioncardTextLogo")
                    .padding(.bottom, 15)
            }
            .frame(width: 230, height: 300)
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}
