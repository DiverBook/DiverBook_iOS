//
//  DiveShadow.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/27/25.
//

import SwiftUI

enum DiveShadow {
    // 동일 수치 적용시 동일 디자인 안나와 피그마 상의 디자인 시스템과 차이가 있습니다.
    static let noneShadow = Shadow(
        color: .clear,
        radius: 0,
        positionX: 0,
        positionY: 0)
    static let shadow1 = Shadow(
        color: DiveColor.color6.opacity(0.18),
        radius: 5,
        positionX: 0,
        positionY: 5)
    static let shadow2 = Shadow(
        color: DiveColor.color5.opacity(0.5),
        radius: 8,
        positionX: 0,
        positionY: -10)
    static let shadow3 = Shadow(
        color: DiveColor.gray4.opacity(0.15),
        radius: 5,
        positionX: 0,
        positionY: 5)
    static let shadow4 = Shadow(
        color: DiveColor.color6.opacity(0.10),
        radius: 20,
        positionX: 0,
        positionY: 6)
}

struct Shadow {
    let color: Color
    let radius: CGFloat
    let positionX: CGFloat
    let positionY: CGFloat
}
