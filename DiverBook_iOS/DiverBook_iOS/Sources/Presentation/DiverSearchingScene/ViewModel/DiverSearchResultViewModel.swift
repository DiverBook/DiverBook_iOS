//
//  DiverSearchResultViewModel.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/22/25.
//

import Combine
import SwiftUI

final class DiverSearchResultViewModel: ViewModelable {
    struct State {
    }
    
    enum Action {
    }
    
    @Published var state: State = State()
    @ObservedObject var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func action(_ action: Action) {
    }
}
