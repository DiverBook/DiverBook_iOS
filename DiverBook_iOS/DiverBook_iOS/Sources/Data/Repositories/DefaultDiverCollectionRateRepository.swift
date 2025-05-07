//
//  DefaultDiverCollectionRateRepository.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/6/25.
//

final class DefaultDiverCollectionRateRepository: DiverCollectionRateRepository {
    private let diverCollectionRateService: DiverCollectionRateServicable
    
    init(diverCollectionRateService: DiverCollectionRateServicable) {
        self.diverCollectionRateService = diverCollectionRateService
    }
    
    func fetchDiverCollectionRate(id: String) async -> Result<Float, Error> {
        let fetchDiverCollectionRateResult = await diverCollectionRateService.fetchDiverCollectionRate(id: id)
        switch fetchDiverCollectionRateResult {
        case .success(let baseResponse):
            if baseResponse.success, let data = baseResponse.data {
                return .success(data)
            }
            else {
                return .failure(RequestError.errorWithLog(baseResponse.errorMessage ?? ""))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
