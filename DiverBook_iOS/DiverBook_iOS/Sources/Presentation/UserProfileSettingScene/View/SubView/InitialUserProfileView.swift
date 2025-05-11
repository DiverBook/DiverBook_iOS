//
//  InitialUserProfileView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/18/25.
//

import Combine
import SwiftUI

struct InitialUserProfileView: View {
    var diverProfileImageUrl: URL?
    var nickname: String
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            // MARK: diver 이미지 뷰 컴포넌트 적용
            ProfileImageView(
                imageURL: diverProfileImageUrl,
                style: .mypage,
                placeholderImageName: "unfoundProfile",
                loadingMethod: .kingfisher
            )
            .padding(.bottom, 15)
            Text(self.nickname).font(DiveFont.bodyMedium1)
                .padding(.bottom, 10)
            Rectangle().fill(Color(.lightGray)).frame(width: 210, height: 1)
                .padding(.bottom, 56)
            Button(action: {
                dismiss()
            }, label: {
                VStack(spacing: 0) {
                    Text("재촬영하기").font(DiveFont.bodyMedium2)
                    Rectangle().fill(.black).frame(width: 70, height: 1)
                }
            })
            .buttonStyle(.plain)
        }
    }
}
