//
//  RoundedCorner.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/28/25.
//
import SwiftUI

struct RoundedCornerView: UIViewRepresentable {
    var radius: CGFloat
    var maskedCorners: CACornerMask
    var color: Color

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(color)
        view.layer.cornerRadius = radius
        view.layer.maskedCorners = maskedCorners
        view.layer.masksToBounds = true
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        uiView.layer.cornerRadius = radius
        uiView.layer.maskedCorners = maskedCorners
        uiView.backgroundColor = UIColor(color)
    }
}
