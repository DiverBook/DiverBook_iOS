//
//  Version.swift
//  DiverBook_iOS
//
//  Created by jun on 5/2/25.
//

import Foundation

struct Version {
    static var current: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
}
