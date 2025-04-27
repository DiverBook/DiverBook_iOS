//
//  MainView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/7/25.
//
import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: MainViewModel
    @GestureState private var dragOffset: CGSize = .zero
    
    init(coordinator: Coordinator) {
        self._viewModel = StateObject(wrappedValue: MainViewModel(coordinator: coordinator))
    }
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 0) {
                    MainTopInfoView(viewModel: self.viewModel)
                        .background(DiveColor.color6)
                        .id("top")
                    DiverCollectionStatusView(viewModel: self.viewModel)
                        .padding(.bottom, 60)
                    Button(action: {
                        withAnimation {
                            proxy.scrollTo("top", anchor: .top)
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "arrow.up")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 12)
                            Text("위로 가기")
                                .font(.subheadline)
                        }
                    })
                    .padding(.bottom, 140)
                }
            }
            .ignoresSafeArea(edges: [.top])
        }
    }
}

#Preview {
    @Previewable @StateObject var coordinator = Coordinator()
    
    MainView(coordinator: coordinator)
}
