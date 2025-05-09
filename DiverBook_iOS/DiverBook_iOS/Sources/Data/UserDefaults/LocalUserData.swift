//
//  LocalUserData.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/10/25.
//

struct LocalUserData {
    @UserDefault(key: "collectedUserCount", defaultValue: 0)
    static var collectedUserCount: Int
}
