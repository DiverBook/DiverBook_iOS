//
//  FlipCardView.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/29/25.
//

import SwiftUI

struct FlipCardView: View {
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    
    let durationAndDelay: CGFloat = 0.3
    let cardIndex: Int
    
    var body: some View {
        ZStack {
            QuestionCardView(degree: $frontDegree, index: cardIndex)
            QuestionCardCell(degree: $backDegree)
        }
        .onAppear {
            flipCard()
        }
    }
    
    private func flipCard() {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay)
                .delay(durationAndDelay)) {
                    frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay)
                .delay(durationAndDelay)) {
                    backDegree = 0
            }
        }
    }
}
