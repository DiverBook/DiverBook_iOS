//
//  TabInsideButton.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/17/25.
//

import Combine
import SwiftUI

struct TabInsideButtons: View {
    @Binding var selectedTab: TabType
    
    var body: some View {
        HStack {
            Spacer().frame(width: 60)

            Button(action: {
                self.selectedTab = .diverBook
            }, label: {
                VStack(spacing: 0) {
                    Spacer().frame(height: 10)
                    Image(systemName: "book").resizable().aspectRatio(
                        contentMode: .fit
                    ).frame(width: 25).foregroundStyle(
                        self.selectedTab == .diverBook ? .blue : .black
                    )
                    .padding(.bottom, 5)
                    Text("도감").font(.system(size: 12))
                        .foregroundStyle(
                            self.selectedTab == .diverBook ? .blue : .black)
                    Spacer()
                }
            })
            .buttonStyle(.plain)

            Spacer()

            Button(action: {
                self.selectedTab = .setting
            }, label: {
                VStack(spacing: 0) {
                    Spacer().frame(height: 10)
                    Image(systemName: "gearshape").resizable().aspectRatio(
                        contentMode: .fit
                    ).frame(width: 25)
                        .padding(.bottom, 3)
                        .foregroundStyle(
                            self.selectedTab == .setting ? .blue : .black)
                    Text("설정").font(.system(size: 12))
                        .foregroundStyle(
                            self.selectedTab == .setting ? .blue : .black)
                    Spacer()
                }
            })
            .buttonStyle(.plain)

            Spacer().frame(width: 60)
        }
        .frame(height: 70)
        .background(.white)
        .shadow(color: .blue.opacity(0.1), radius: 10, y: -5)
    }
}
