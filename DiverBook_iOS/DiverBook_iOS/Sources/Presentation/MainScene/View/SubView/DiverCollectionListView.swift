//
//  DiverCollectionListView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/23/25.
//

import Combine
import SwiftUI

struct DiverCollectionListView: View {
    @StateObject var viewModel: DiverCollectionListViewModel = DiverCollectionListViewModel()

    #warning("TODO: diver 정보를 파라미터로 입력하도록 수정")
    var diverTapAction: () -> Void
    
    init(diverTapAction: @escaping () -> Void) {
        self.diverTapAction = diverTapAction
    }
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(minimum: 80, maximum: 200)),
            GridItem(.flexible(minimum: 80, maximum: 200)),
            GridItem(.flexible(minimum: 80, maximum: 200))
        ]) {
            ForEach(0..<100) { index in
                PrimaryProfile(image: Image("diver-air"), nickname: "Air", style: .diver)
            }
        }
    }
}

class DiverCollectionListViewModel: ViewModelable {
    struct State {

    }

    enum Action {

    }

    @Published var state: State = State()

    func action(_ action: Action) {

    }
}

#Preview {
    DiverCollectionListView(diverTapAction: {
        
    })
}
