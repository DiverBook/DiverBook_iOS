//
//  CollectedDiverResModel.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/9/25.
//

struct CollectedDiverResModel: Decodable {
    var id: Int
    var ownerId: String
    var foundUserId: String
    var foundDate: String
    var memo: String?
}

extension CollectedDiverResModel {
    func toDomain() -> CollectedDiverInfo {
        return CollectedDiverInfo(
            id: id,
            ownerId: ownerId,
            foundUserId: foundUserId,
            foundDate: foundDate,
            memo: memo ?? ""
        )
    }
}
