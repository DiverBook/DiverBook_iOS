//
//  DiverBookAuthServicable.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/29/25.
//

protocol DiverBookAuthServicable: HTTPClient {
    func signUp(
        userName: String,
        divisions: String,
        phoneNumber: String,
        interests: String,
        places: String,
        about: String,
        password: String
    ) async -> Result<BaseResponse<SignUpResModel>, RequestError>
    
    func refreshToken(
        refreshToken: String
    ) async -> Result<BaseResponse<RefreshTokenResModel>, RequestError>
}
