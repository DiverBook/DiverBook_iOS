//
//  OnboardIntroIndicator.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/17/25.
//

import Combine
import SwiftUI

struct OnboardIntroIndicator: View {
    @Binding var selectedTabIndex: Int
    
    var body: some View {
        HStack {
            ForEach(0..<2) { index in
                Circle().fill(
                    self.selectedTabIndex == index ? .blue : .gray
                ).frame(width: 6)
            }
        }
    }
}
