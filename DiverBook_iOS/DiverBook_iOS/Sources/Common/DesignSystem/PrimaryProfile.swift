//
//  PrimaryProfile.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/18/25.
//

import SwiftUI

struct PrimaryProfile: View {
    let image: Image
    let nickname: String?
    let hasShadow: Bool
    let style: ProfileStyle

    init(image: Image,
         nickname: String? = nil,
         hasShadow: Bool = true,
         style: ProfileStyle) {
        self.image = image
        self.nickname = nickname
        self.hasShadow = hasShadow
        self.style = style
    }

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill((DiveColor.white))
                    .frame(width: style.imageSize, height: style.imageSize)
                    .shadow(color: hasShadow ? DiveColor.color6.opacity(0.18) : .clear,
                            radius: hasShadow ? 5 : 0, y: 5)
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: style.imageSize, height: style.imageSize)
                    .clipShape(Circle())
            }
            
            if let nickname = nickname {
                Text(nickname)
                    .font(style.nicknameFont)
                    .foregroundColor(DiveColor.gray4)
            }
        }
    }
}

enum ProfileStyle {
    case found
    case mypage
    case diver
    case basic
    
    var imageSize: CGFloat {
        switch self {
        case .found:
            return 160
        case .mypage:
            return 136
        case .diver:
            return 100
        case .basic:
            return 75
        }
    }
    
    var nicknameFont: Font? {
        switch self {
        case .found:
            return nil
        case .mypage:
            return DiveFont.headingH3
        case .diver:
            return DiveFont.bodyMedium1
        case .basic:
            return nil
        }
    }
}

#Preview {
    // 러너 발견 시점 - found
    PrimaryProfile(image: Image("exMemoji"), style: .found)
    // 내 프로필 - mypage
    PrimaryProfile(image: Image("exMemoji"), nickname: "Berry", style: .mypage)
    // 도감 목록 - diver
    PrimaryProfile(image: Image("exMemoji"), nickname: "Berry", style: .diver)
    // 기본 프로필(메인 화면과 다이버 카드) - basic
    PrimaryProfile(image: Image("exMemoji"), style: .basic)
    // shadow 필요없는 경우
    PrimaryProfile(image: Image("exMemoji"), hasShadow: false, style: .basic)
}
