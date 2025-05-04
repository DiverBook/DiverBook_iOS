//
//  DiverInfo.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/30/25.
//

import Foundation

struct DiverProfile {
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
        userName: "Air",
        divisions: "테크",
        phoneNumber: "010-1234-1234",
        interests: "사진, 공기",
        places: "C5",
        about: "공기는 눈에 보이지 않지만 어디에나 있습니다.",
        profileImageUrlString: "https://diverbook.sijun.dev/api/images/view/Air.png"
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
