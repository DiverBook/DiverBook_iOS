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
    let isPopup: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: CGFloat(18))
                .frame(width: isPopup ? 230 : 150, height: isPopup ? 300 : 200)
                .foregroundColor(DiveColor.white)
                .padding(.bottom, 10)
            VStack(alignment: .center) {
                Image("questioncardImageLogo")
                    .foregroundColor(DiveColor.color2)
                    .padding(.top, isPopup ? 60 : 40)
                    .padding(.bottom, isPopup ? 30 : 20)
                Divider()
                    .foregroundColor(DiveColor.gray1)
                    .padding(.bottom, 11)
                    .frame(width: 14)
                Text("\(question.question)")
                    .multilineTextAlignment(.center)
                    .frame(width: isPopup ? 180 : 120)
                    .font(isPopup ? DiveFont.bodyRegularPretendard : DiveFont.bodyExtra1)
                    .foregroundColor(DiveColor.gray4)
                Spacer()
            }
            .frame(width: isPopup ? 230 : 150, height: isPopup ? 300 : 200)
        }
        .applyShadow(DiveShadow.shadow3)
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}
