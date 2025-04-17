//
//  DiverBookTabBar.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/15/25.
//

import Combine
import SwiftUI

struct DiverBookTabBar: View {
    @Binding var selectedTab: TabType

    var body: some View {
        ZStack {
            TabInsideButtons(selectedTab: self.$selectedTab)
            SearchTabButton()
        }
    }
}

#Preview {
    @Previewable @State var selectedTab: TabType = .diverBook
    VStack {
        Spacer()
        DiverBookTabBar(selectedTab: $selectedTab)
    }
    .ignoresSafeArea()
}
