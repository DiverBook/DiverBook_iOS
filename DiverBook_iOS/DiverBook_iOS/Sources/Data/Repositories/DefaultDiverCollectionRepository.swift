//
//  DefaultDiverCollectionRepository.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/6/25.
//

final class DefaultDiverCollectionRepository: DiverCollectionRepository {
    
    private let diverCollectionService: DiverCollectionServicable
    
    init(diverCollectionService: DiverCollectionServicable) {
        self.diverCollectionService = diverCollectionService
    }
    
    func fetchAllDiverList() async -> Result<[DiverProfile], Error> {
        let fetchAllDiverListResult = await diverCollectionService.fetchAllDiverList()
        switch fetchAllDiverListResult {
        case .success(let baseResponse):
            if baseResponse.success, let data = baseResponse.data {
                return .success(data.map { $0.toDomain() })
            } else {
                return .failure(RequestError.errorWithLog(baseResponse.errorMessage ?? ""))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func fetchDiverCollection() async -> Result<[CollectedDiverInfo], Error> {
        let fetchDiverCollectionResult = await diverCollectionService.fetchDiverCollection()
        switch fetchDiverCollectionResult {
        case .success(let baseResponse):
            if baseResponse.success, let data = baseResponse.data {
                return .success(data.map { $0.toDomain() })
            } else {
                return .failure(RequestError.errorWithLog(baseResponse.errorMessage ?? ""))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func updateDiverMemo(
        foundUserId: String,
        memo: String) async -> Result<CollectedDiverInfo, Error> {
        let result = await diverCollectionService.updateDiverMemo(
            foundUserId: foundUserId,
            memo: memo)
        
        switch result {
        case .success(let baseResponse):
            if baseResponse.success, let data = baseResponse.data {
                return .success(data.toDomain())
            } else {
                return .failure(RequestError.errorWithLog(baseResponse.errorMessage ?? "메모 업데이트 실패"))
            }

        case .failure(let error):
            return .failure(error)
        }
    }
    
    func saveDiverMemo(
        foundUserId: String,
        memo: String) async -> Result<CollectedDiverInfo, Error> {
        let result = await diverCollectionService.saveDiverMemo(
            foundUserId: foundUserId,
            memo: memo)
        
        switch result {
        case .success(let baseResponse):
            if baseResponse.success, let data = baseResponse.data {
                return .success(data.toDomain())
            } else {
                return .failure(RequestError.errorWithLog(baseResponse.errorMessage ?? "메모 저장 실패"))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
