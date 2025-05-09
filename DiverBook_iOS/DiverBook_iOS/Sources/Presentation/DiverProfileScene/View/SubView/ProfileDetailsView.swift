//
//  ProfileDetailsView.swift
//  DiverProfile
//
//  Created by bear on 4/17/25.
//

import SwiftUI

struct ProfileDetailsInfoView: View {
    let division: ProfileInfoMode
    let phoneNumber: ProfileInfoMode
    let interests: ProfileInfoMode
    let places: ProfileInfoMode

    var body: some View {
        VStack(spacing: 32) {
            ProfileInfoRow(title: "희망분야", mode: division)
            ProfileInfoRow(title: "연락처", mode: phoneNumber)
            ProfileInfoRow(title: "관심사", mode: interests)
            ProfileInfoRow(title: "자주 가는 장소", mode: places)
        }
    }
}

