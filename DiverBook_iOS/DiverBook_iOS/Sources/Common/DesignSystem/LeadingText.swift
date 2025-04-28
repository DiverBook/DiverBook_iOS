//
//  LeadingText.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/23/25.
//

import SwiftUI

struct LeadingText: View {
    var text: String
    
    
    var body: some View {
        HStack(spacing: 0) {
            Text(self.text)
            Spacer()
        }
    }
}
