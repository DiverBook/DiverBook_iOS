//
//  ProfileDetailsView.swift
//  DiverProfile
//
//  Created by bear on 4/17/25.
//

import SwiftUI

struct ProfileDetailsInfoView: View {
    var division: ProfileInfoMode
    var phoneNumber: ProfileInfoMode
    var interests: ProfileInfoMode
    var places: ProfileInfoMode

    var body: some View {
        VStack(spacing: 32) {
            ProfileInfoRow(title: "희망분야", mode: division)
            ProfileInfoRow(title: "연락처", mode: phoneNumber)
            ProfileInfoRow(title: "관심사", mode: interests)
            ProfileInfoRow(title: "자주 가는 장소", mode: places)
        }
    }
}

#Preview {
    ProfileDetailsInfoView(
        division: .readOnly(text: "디자인"),
        phoneNumber: .readOnly(text: "010-0000-0000"),
        interests: .readOnly(text: "사진"),
        places: .readOnly(text: "C5")
    )
}
