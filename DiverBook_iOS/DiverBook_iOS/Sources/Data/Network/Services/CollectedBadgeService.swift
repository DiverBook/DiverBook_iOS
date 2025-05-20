//
//  BadgeService.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

final class CollectedBadgeService: BadgeServicable {
    func fetchUserBadges() async -> Result<
        BaseResponse<[CollectedBadgeResModel]>, RequestError
    > {
        return await request(
            endpoint: BadgeEndpoint.getUserBadges,
            responseModel: BaseResponse<[CollectedBadgeResModel]>.self
        )
    }
    
    func postUserBadge(badgeCode: String) async -> Result<BaseResponse<CollectedBadgeResModel>, RequestError> {
        return await request(
            endpoint: BadgeEndpoint.postUserBadge(badgeCode: badgeCode),
            responseModel: BaseResponse<CollectedBadgeResModel>.self
        )
    }
}
