//
//  DiverInfo.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/30/25.
//

import Foundation

struct DiverProfile: Hashable {
    var id: String
    var userName: String
    var divisions: String
    var phoneNumber: String
    var interests: String
    var places: String
    var about: String
    var profileImageUrlString: String
    
    var profileImageUrl: URL? {
        return URL(string: profileImageUrlString)
    }
}

extension DiverProfile {
    static let mockData = DiverProfile(
        id: "",
        userName: "",
        divisions: "",
        phoneNumber: "",
        interests: "",
        places: "",
        about: "",
        profileImageUrlString: ""
    )
    
    static let unfoundMockData = DiverProfile(
        id: "",
        userName: "Air",
        divisions: "",
        phoneNumber: "",
        interests: "",
        places: "",
        about: "",
        profileImageUrlString: ""
    )
}
