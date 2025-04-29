//
//  FlipCardView.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/29/25.
//

import SwiftUI

struct FlipCardView: View {
    @State var backDegree = 0.0
    @State var frontDegree = -89.9
    @State var isFlipped = false
    
    let durationAndDelay: CGFloat = 0.3
    let cardIndex: Int
    
    var body: some View {
        ZStack {
            QuestionCardFrontView(degree: $frontDegree, index: cardIndex)
            QuestionCardBackView(degree: $backDegree)
        }
        .onAppear {
            flipCard()
        }
    }
    
    private func flipCard() {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 89.9
            }
            withAnimation(.linear(duration: durationAndDelay)
                .delay(durationAndDelay)) {
                    frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -89.9
            }
            withAnimation(.linear(duration: durationAndDelay)
                .delay(durationAndDelay)) {
                    backDegree = 0
            }
        }
    }
}
