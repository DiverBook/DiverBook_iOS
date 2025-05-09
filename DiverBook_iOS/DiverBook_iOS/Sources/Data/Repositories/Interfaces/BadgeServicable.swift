//
//  BadgeServicable.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

protocol BadgeServicable: HTTPClient {
    func fetchBadges() async -> Result<BaseResponse<[BadgeResponseModel]>, RequestError>
    func fetchUserBadges() async -> Result<BaseResponse<[UserBadgeResponseModel]>, RequestError>
}
