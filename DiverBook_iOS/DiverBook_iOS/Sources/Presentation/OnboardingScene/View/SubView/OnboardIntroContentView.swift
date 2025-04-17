//
//  OnboardIntroContentView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/17/25.
//

import SwiftUI

struct OnboardIntroContentView: View {
    
    var title: String
    var imageName: String
    var padding: CGFloat
    var imagePadding: CGFloat
    
    init(title: String, imageName: String, padding: CGFloat, imagePadding: CGFloat = 0) {
        self.title = title
        self.imageName = imageName
        self.padding = padding
        self.imagePadding = imagePadding
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text(self.title)
                .font(DiveFont.headingH3)
                .multilineTextAlignment(.center)
                .lineSpacing(3)
                .padding(.bottom, self.padding)
            Image(self.imageName).resizable().aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - self.imagePadding)
        }
    }
}
