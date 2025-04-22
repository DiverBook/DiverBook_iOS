//
//  UUIDManager.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/21/25.
//

import Foundation

class UUIDManager {
    static let shared = UUIDManager()
    
    private let key = "deviceUUID"
    private init() {}
    
    var uuid: String {
        if let saved = UserDefaults.standard.string(forKey: key) {
            return saved
        } else {
            let newUUID = UUID().uuidString
            UserDefaults.standard.set(newUUID, forKey: key)
            return newUUID
        }
    }
}
