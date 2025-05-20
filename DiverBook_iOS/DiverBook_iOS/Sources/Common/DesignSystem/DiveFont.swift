//
//  DiveFont.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/15/25.
//

import SwiftUI

enum DiveFont {
    /// size: 22, weight: bold
    static let title2Emphasized: Font = .system(size: 22, weight: .bold)
    /// size: 28, weight: semibold
    static let headingH1: Font = .system(size: 28, weight: .semibold)
    /// size: 24, weight: semibold
    static let headingH2: Font = .system(size: 24, weight: .semibold)
    /// size: 20, weight: semibold
    static let headingH3: Font = .system(size: 20, weight: .semibold)
    /// size: 16, weight: semibold
    static let bookAttainment: Font = .system(size: 16, weight: .semibold)
    /// size: 18, weight: regular
    static let bodyLarge: Font = .system(size: 18, weight: .regular)
    /// size: 16, weight: regular
    static let bodyMedium1: Font = .system(size: 16, weight: .regular)
    /// size: 14, weight: regular
    static let bodyMedium2: Font = .system(size: 14, weight: .regular)
    /// size: 14, weight: semibold
    static let bodySemibold: Font = .system(size: 14, weight: .semibold)
    /// size: 12, weight: regular
    static let bodyExtra1: Font = .system(size: 12, weight: .regular)
    /// size: 10, weight: regular
    static let bodyExtra2: Font = .system(size: 10, weight: .regular)
    /// size: 16, weight: regular
    static let button: Font = .system(size: 16, weight: .regular)
    /// size: 18, weight: medium
    static let bar: Font = .system(size: 18, weight: .semibold)
    /// size: 18 , weight: semibold
    static let bodyPretendard: Font = .custom("Pretendard-SemiBold", size: 18)
    /// size: 16, weight: semibold
    static let bodyMediumPretendard: Font = .custom("Pretendard-SemiBold", size: 16)
    /// size: 14, weight: semibold
    static let bodySmallPretendard: Font = .custom("Pretendard-SemiBold", size: 14)
    /// size: 18 , weight: regular
    static let bodyRegularPretendard: Font = .custom("Pretendard-Regular", size: 18)
}
