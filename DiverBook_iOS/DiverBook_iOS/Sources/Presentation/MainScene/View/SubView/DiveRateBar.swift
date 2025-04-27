//
//  DiveRateBar.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/23/25.
//

import Combine
import SwiftUI

struct DiveRateBar: View {
    @Binding var rate: Double
    @State var isLoading: Bool = true
    @State var gageOffset: CGFloat
    var barWidth: CGFloat
    
    init(rate: Binding<Double>, barWidth: CGFloat = UIScreen.main.bounds.width - 150) {
        self._rate = rate
        self.barWidth = barWidth
        self.gageOffset = -barWidth
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Capsule()
                .fill(DiveColor.color2)
                .frame(width: self.barWidth, height: 22)
                .overlay(
                    Capsule()
                        .fill(self.isLoading ? DiveColor.color2 : DiveColor.color5)
                        .frame(width: self.barWidth, height: 22).offset(x: gageOffset)
                )
                .clipShape(Capsule())
            Spacer()
            Text("\(Int(self.rate))%")
                .font(DiveFont.headingH3)
                .foregroundStyle(DiveColor.color5)
        }
        .onAppear {
            withAnimation(.spring(response: 1.5, dampingFraction: 0.7)) {
                self.gageOffset = -(self.barWidth - (rate / 100) * self.barWidth)
                self.isLoading = false
            }
        }
    }
}

#Preview {
    @Previewable @State var rate: Double = 50
    DiveRateBar(rate: $rate)
}
