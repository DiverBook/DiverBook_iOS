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
    let animationNamespace: Namespace.ID
    let question: Question
    
    var body: some View {
        ZStack {
            if frontDegree >= -90 {
                QuestionCardFrontView(
                    degree: $frontDegree,
                    index: cardIndex,
                    question: question,
                    isPopup: true
                )
                .zIndex(1)
            }
            
            if backDegree <= 90 {
                QuestionCardBackView(degree: $backDegree)
                    .matchedGeometryEffect(id: cardIndex, in: animationNamespace)
                    .zIndex(0)
            }
        }
        .frame(width: 230, height: 300)
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
