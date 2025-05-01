//
//  DiverBookAuthService.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 4/28/25.
//

final class DiverBookAuthService: DiverBookAuthServicable {
    func signUp(
        userName: String,
        divisions: String,
        phoneNumber: String,
        interests: String,
        places: String,
        about: String,
        password: String
    ) async -> Result<SignUpResModel, RequestError> {
        return await request(
            endpoint: DiverBookAuthEndpoint.signUp(
                userName: userName,
                divisions: divisions,
                phoneNumber: phoneNumber,
                interests: interests,
                places: places,
                about: about,
                password: password
            ),
            responseModel: SignUpResModel.self)
    }

}
