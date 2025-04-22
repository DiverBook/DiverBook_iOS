//
//  DiverSearchingView.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/20/25.
//

import SwiftUI

struct DiverSearchingView: View {
    @StateObject var viewModel: DiverSearchingViewModel
    @StateObject private var dataTransferManager: DataTransferManager
    
    private let advertiseManager: AdvertiserManager
    private let browseManager: BrowserManager
    
    init(coordinator: Coordinator) {
        let viewModel = DiverSearchingViewModel(coordinator: coordinator)
        _viewModel = StateObject(wrappedValue: viewModel)
        let nickname = "Berry"
        let manager = DataTransferManager(nickname: nickname, viewModel: viewModel)
        self._dataTransferManager = StateObject(wrappedValue: manager)
        self.advertiseManager = AdvertiserManager(dataTransferManager: manager)
        self.browseManager = BrowserManager(dataTransferManager: manager)
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 10) {
            TopBar()
            Spacer()
            LottieView(animationName: "DiverDrop", shouldPlay: true)
                .frame(width: 350, height: 100)
                .padding(.bottom, 40)
            Text("만나는 다이버에게 이렇게 질문해보세요")
                .font(DiveFont.bodyMedium1)
                .foregroundColor(DiveColor.gray4)
            Group {
                Text("“같이 ")
                    .foregroundColor(DiveColor.gray4)
                + Text("다이빙 ")
                    .foregroundColor(DiveColor.color6)
                + Text("하실래요?”")
                    .foregroundColor(DiveColor.gray4)
            }
            .font(DiveFont.headingH2)
            
            HStack(spacing: 5) {
                ProgressView()
                Text("탐색중...")
                    .font(DiveFont.bodyMedium2)
                    .foregroundColor(DiveColor.gray3)
            }
            .padding(.top, 100)
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .onAppear {
            dataTransferManager.startSession()
        }
        .onDisappear {
            dataTransferManager.stopSession()
        }
    }
}
