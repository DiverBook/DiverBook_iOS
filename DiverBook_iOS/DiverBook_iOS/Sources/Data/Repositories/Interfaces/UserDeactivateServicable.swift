//
//  UserDeactivateServicable.swift
//  DiverBook_iOS
//
//  Created by jun on 5/8/25.
//

import Foundation

protocol UserDeactivateServicable: HTTPClient {
    func deactivateUser(refreshToken: String) async -> Result<
        BaseResponse<DiverProfileResModel>, RequestError
    >
}
