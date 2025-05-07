//
//  BadgeServicable.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

protocol BadgeServicable {
    func fetchBadges() async -> Result<BaseResponse<[BadgeResponseModel]>, RequestError>
}
