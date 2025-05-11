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
    let question: Question
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: CGFloat(18))
                .frame(width: 230, height: 300)
                .foregroundColor(DiveColor.white)
            VStack(alignment: .center) {
                Image("questioncardImageLogo")
                    .foregroundColor(DiveColor.color2)
                    .padding(.top, 60)
                    .padding(.bottom, 30)
                Divider()
                    .foregroundColor(DiveColor.gray1)
                    .padding(.bottom, 11)
                    .frame(width: 14)
                Text("\(question.question)")
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
