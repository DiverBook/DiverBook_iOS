//
//  ProfileDetailsView.swift
//  DiverProfile
//
//  Created by bear on 4/17/25.
//

import SwiftUI

struct ProfileDetailsInfoView: View {
    var division: String
    var phoneNumber: String
    var interests: String
    var places: String
    
    var body: some View {
        VStack(spacing: 32) {
            ProfileInfoRow(title: "희망분야", content: division)
            ProfileInfoRow(title: "연락처", content: phoneNumber)
            ProfileInfoRow(title: "관심사", content: interests)
            ProfileInfoRow(title: "자주 가는 장소", content: places)
        }
    }
}

#Preview {
    ProfileDetailsInfoView(
        division: "디자인",
        phoneNumber: "010-0000-0000",
        interests: "사진",
        places: "C5"
    )
}
