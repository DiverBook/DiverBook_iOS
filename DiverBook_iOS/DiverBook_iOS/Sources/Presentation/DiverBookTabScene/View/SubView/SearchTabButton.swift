//
//  SearchTabButton.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/17/25.
//

import Combine
import SwiftUI

struct SearchTabButton: View {
    var body: some View {
        VStack {
            Image("search").resizable().aspectRatio(contentMode: .fit)
                .frame(width: 80)
                .onTapGesture {
                }
            Spacer().frame(height: 30)
        }
    }
}
