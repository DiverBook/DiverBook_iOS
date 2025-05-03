//
//  DefaultDiverRepository.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/1/25.
//

final class DefaultDiverRepository: DiverRepository {
    private let diverProfileService: DiverProfileServicable
    
    init(diverProfileService: DiverProfileServicable) {
        self.diverProfileService = diverProfileService
    }
    
    func fetchDiverProfile(id: String) async -> Result<DiverProfile, Error> {
        let profileResult = await diverProfileService.fetchDiverProfile(id: id)
        
        switch profileResult {
        case .success(let baseResponse):
            if baseResponse.success, let data = baseResponse.data {
                let diverProfile = data.toDomain()
                return .success(diverProfile)
            } else {
                let errorMessage = baseResponse.errorMessage ?? "Error"
                return .failure(RequestError.unknown)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
