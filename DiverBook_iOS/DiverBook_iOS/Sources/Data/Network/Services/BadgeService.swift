//
//  BadgeService.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

final class BadgeService: BadgeServicable {
    func fetchBadges() async -> Result<
        BaseResponse<[BadgeResponseModel]>, RequestError
    > {
        return await request(
            endpoint: BadgeEndpoint.getBadges,
            responseModel: BaseResponse<[BadgeResponseModel]>.self
        )
    }

    func fetchUserBadges() async -> Result<
        BaseResponse<[UserBadgeResponseModel]>, RequestError
    > {
        return await request(
            endpoint: BadgeEndpoint.getUserBadges,
            responseModel: BaseResponse<[UserBadgeResponseModel]>.self
        )
    }
}
