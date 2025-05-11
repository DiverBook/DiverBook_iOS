//
//  DiverCollectionServicable.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/6/25.
//

protocol DiverCollectionServicable: HTTPClient {
    func fetchAllDiverList() async -> Result<BaseResponse<[DiverProfileResModel]>, RequestError>
    func fetchDiverCollection() async -> Result<BaseResponse<[CollectedDiverResModel]>, RequestError>
    func updateDiverMemo(foundUserId: String, memo: String) async -> Result<BaseResponse<CollectedDiverResModel>, RequestError>
    func saveDiverMemo(foundUserId: String, memo: String) async -> Result<BaseResponse<CollectedDiverResModel>, RequestError>
}
