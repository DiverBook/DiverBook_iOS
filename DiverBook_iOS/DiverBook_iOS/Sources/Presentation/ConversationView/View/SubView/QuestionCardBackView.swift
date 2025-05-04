//
//  QuestionCardCell.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/27/25.
//

import SwiftUI

struct QuestionCardBackView: View {
    @Binding var degree: Double
    
    var body: some View {
        Image("questionCard")
            .applyShadow(DiveShadow.shadow3)
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}
