//
//  DiverProfileServicable.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/1/25.
//

protocol DiverProfileServicable: HTTPClient {
    func fetchProfileImageUrl(nickName: String) async -> Result<BaseResponse<String>, RequestError>
    
    func fetchDiverProfile(
        id: String
    ) async -> Result<BaseResponse<DiverProfileResModel>, RequestError>
    
    func fetchMyProfile() async -> Result<BaseResponse<DiverProfileResModel>, RequestError>
    
    func updateMyProfile(
           divisions: String,
           phoneNumber: String,
           interests: String,
           places: String,
           about: String
       ) async -> Result<BaseResponse<DiverProfileResModel>, RequestError>
}
