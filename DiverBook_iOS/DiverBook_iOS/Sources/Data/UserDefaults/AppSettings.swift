//
//  AppData.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/1/25.
//


struct AppSettings {
    @UserDefault(key: "hasLaunched", defaultValue: false)
    static var hasLaunched: Bool
}
