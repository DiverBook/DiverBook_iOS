//
//  BadgeService.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

final class BadgeService: BadgeServicable, HTTPClient {
    func fetchBadges() async -> Result<BaseResponse<[BadgeResponseModel]>, RequestError> {
        return await request(
            endpoint: BadgeEndpoint.getBadges,
            responseModel: BaseResponse<[BadgeResponseModel]>.self
        )
    }
}
