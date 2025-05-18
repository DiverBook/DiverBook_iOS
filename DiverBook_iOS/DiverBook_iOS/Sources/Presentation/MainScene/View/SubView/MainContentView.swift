//
//  MainContentView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/7/25.
//

import SwiftUI

struct MainContentView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                if viewModel.state.isDataFetching {
                    VStack(spacing: 0) {
                        MainTopInfoView(viewModel: self.viewModel)
                            .padding(.horizontal, 13)
                            .padding(.top, 100)
                            .padding(.bottom, 40)
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
                    .redacted(reason: .placeholder)
                }
                else {
                    VStack(spacing: 0) {
                        MainTopInfoView(viewModel: self.viewModel)
                            .padding(.top, 100)
                            .padding(.bottom, 40)
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
            }
            .ignoresSafeArea(edges: [.top])
            .disabled(viewModel.state.tapDisabled)
        }
        .onAppear {
            viewModel.action(.viewAppeared)
        }
    }
}
