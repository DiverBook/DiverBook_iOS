//
//  LottieView.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/20/25.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    var animationName: String
    var shouldPlay: Bool

    func makeUIView(context: Context) -> some UIView {
        let animationView = LottieAnimationView(name: animationName)
        animationView.loopMode = .loop
        if shouldPlay {
            animationView.play()
        }
        return animationView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        // 필요 시점에 작성
    }
}
