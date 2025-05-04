//
//  DiverProfileModel+Mapping.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 4/30/25.
//

import Foundation

struct DiverProfileResModel: Decodable {
    var id: String
    var userName: String
    var divisions: String?
    var phoneNumber: String?
    var interests: String?
    var places: String?
    var about: String?
    var profileImageUrl: String
}

extension DiverProfileResModel {
    func toDomain() -> DiverProfile {
        return .init(
            id: id,
            userName: userName,
            divisions: divisions ?? "",
            phoneNumber: phoneNumber ?? "",
            interests: interests ?? "",
            places: places ?? "",
            about: about ?? "",
            profileImageUrl: profileImageUrl
        )
    }
}
