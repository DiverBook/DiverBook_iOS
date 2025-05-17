//
//  BadgeServicable.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

protocol BadgeServicable: HTTPClient {
    func fetchUserBadges() async -> Result<BaseResponse<[CollectedBadgeResModel]>, RequestError>
    func postUserBadge(badgeCode: String) async -> Result<CollectedBadgeResModel, RequestError>
}
