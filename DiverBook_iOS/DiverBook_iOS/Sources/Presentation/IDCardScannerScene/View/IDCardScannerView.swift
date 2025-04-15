//
//  IDCardScannerView.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/10/25.
//

import Combine
import CoreImage
import SwiftUI
import UIKit

struct IDCardScannerView: View {
    @ObservedObject var viewModel: IDCardScannerViewModel
    
    init(viewModel: IDCardScannerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            
        }
    }
}

#Preview {
    IDCardScannerView(viewModel: IDCardScannerViewModel())
}
