//
//  DiverProfileService.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/1/25.
//

final class DiverProfileService: DiverProfileServicable {
    func fetchProfileImageUrl(nickName: String) async -> Result<BaseResponse<String>, RequestError> {
        return await request(
            endpoint: DiverProfileEndpoint.profileImageUrl(nickName: nickName),
            responseModel: BaseResponse<String>.self
        )
    }
    
    func fetchDiverProfile(
        id: String
    ) async -> Result<BaseResponse<DiverProfileResModel>, RequestError> {
        return await request(
            endpoint: DiverProfileEndpoint.diverProfile(id: id),
            responseModel: BaseResponse<DiverProfileResModel>.self
        )
    }
    
    func fetchMyProfile() async -> Result<BaseResponse<DiverProfileResModel>, RequestError> {
        return await request(
            endpoint: DiverProfileEndpoint.myProfile,
            responseModel: BaseResponse<DiverProfileResModel>.self
        )
    }
    
    func updateMyProfile(
        divisions: String,
        phoneNumber: String,
        interests: String,
        places: String,
        about: String
    ) async -> Result<BaseResponse<DiverProfileResModel>, RequestError> {
        return await request(
            endpoint: DiverProfileEndpoint.updateMyProfile(
                divisions: divisions,
                phoneNumber: phoneNumber,
                interests: interests,
                places: places,
                about: about
            ),
            responseModel: BaseResponse<DiverProfileResModel>.self
        )
    }
}
