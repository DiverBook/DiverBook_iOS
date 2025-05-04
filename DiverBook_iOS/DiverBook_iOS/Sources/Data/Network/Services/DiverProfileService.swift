//
//  DiverProfileService.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/1/25.
//

final class DiverProfileService: DiverProfileServicable {
    func fetchDiverProfile(
        id: String
    ) async -> Result<BaseResponse<DiverProfileResModel>, RequestError> {
        return await request(
            endpoint: DiverProfileEndpoint.diverProfile(id: id),
            responseModel: BaseResponse<DiverProfileResModel>.self
        )
    }
}
