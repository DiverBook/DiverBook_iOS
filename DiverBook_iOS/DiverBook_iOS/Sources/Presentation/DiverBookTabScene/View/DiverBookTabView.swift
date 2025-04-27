//
//  DiverBookTabView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/15/25.
//

import SwiftUI

struct DiverBookTabView: View {
    @StateObject var viewModel: DiverBookTabViewModel
    
    init(coordinator: Coordinator) {
        self._viewModel = StateObject(wrappedValue: DiverBookTabViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: self.$viewModel.state.selectedTab) {
                // MARK: TabType에 따라 Tag 부착
                MainView(coordinator: self.viewModel.coordinator)
                    .tag(TabType.diverBook)
                
                Text("setting")
                    .tag(TabType.setting)
            }
            .tabViewStyle(.page)
            DiverBookTabBar(
                selectedTab: self.$viewModel.state.selectedTab,
                selectSearchTab: {
                    viewModel.action(.selectSearchTab)
                }
            )
        }
        .ignoresSafeArea(edges: [.bottom])
    }
}
