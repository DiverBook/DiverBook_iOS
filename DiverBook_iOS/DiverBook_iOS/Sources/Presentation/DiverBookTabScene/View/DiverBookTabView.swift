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
        _viewModel = StateObject(wrappedValue: DiverBookTabViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: self.$viewModel.state.selectedTab) {
                // MARK: TabType에 따라 Tag 부착
                MainView(viewModel: MainViewModel(coordinator: self.viewModel.coordinator))
                    .tag(TabType.diverBook)
                
                // MARK: 탐색 뷰는 탭 아이템 누를 시 탭 뷰로 보여지지 않고 새로운 뷰로 Navigating
                
                Text("setting")
                    .tag(TabType.setting)
            }
            .tabViewStyle(.page)
            DiverBookTabBar(selectedTab: self.$viewModel.state.selectedTab)
        }
        .ignoresSafeArea(edges: [.bottom])
    }
}

#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    DiverBookTabView(coordinator: coordinator)
}
