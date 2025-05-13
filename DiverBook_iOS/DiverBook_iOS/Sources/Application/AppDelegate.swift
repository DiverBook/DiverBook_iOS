//
//  AppDelegate.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/14/25.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        DiverBookIOSFontFamily.registerAllCustomFonts()
        return true
    }
}
