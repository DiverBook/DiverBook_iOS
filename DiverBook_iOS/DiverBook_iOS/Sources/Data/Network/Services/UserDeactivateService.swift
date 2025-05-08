//
//  UserDeactivateService.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

final class UserDeactivateService: UserDeactivateServicable {
    func deactivateUser() async -> Result<BaseResponse<DiverProfileResModel>, RequestError> {
        return await request(
            endpoint: UserDeactivateEndpoint.deactivate,
            responseModel: BaseResponse<DiverProfileResModel>.self
        )
    }
}
