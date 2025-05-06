//
//  DefaultCollectionRateUseCase.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/6/25.
//

final class DefaultDiverCollectionRateUseCase: DiverCollectionRateUseCase {
    let diverCollectionRateRepository: DiverCollectionRateRepository
    
    init(diverCollectionRateRepository: DiverCollectionRateRepository) {
        self.diverCollectionRateRepository = diverCollectionRateRepository
    }
    
    func executeFetchDiverCollectionRate(id: String) async -> Result<Float, Error> {
        let diverCollectionRateResult = await diverCollectionRateRepository.fetchDiverCollectionRate(id: id)
        switch diverCollectionRateResult {
        case .success(let successRate):
            return .success(successRate)
        case .failure(let error):
            return .failure(error)
        }
    }
}
