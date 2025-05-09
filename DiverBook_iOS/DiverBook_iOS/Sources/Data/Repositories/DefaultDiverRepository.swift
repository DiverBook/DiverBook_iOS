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

    func fetchMyProfile() async -> Result<DiverProfile, Error> {
        let myProfileResult = await diverProfileService.fetchMyProfile()

        switch myProfileResult {
        case .success(let baseResponse):
            if baseResponse.success, let data = baseResponse.data {
                let myProfile = data.toDomain()
                return .success(myProfile)
            } else {
                return .failure(
                    RequestError.errorWithLog(baseResponse.errorMessage ?? "")
                )
            }
        case .failure(let error):
            return .failure(error)
        }
    }

    func updateMyProfile(
        divisions: String,
        phoneNumber: String,
        interests: String,
        places: String,
        about: String
    ) async -> Result<DiverProfile, Error> {
        let updateMyResult = await diverProfileService.updateMyProfile(
            divisions: divisions,
            phoneNumber: phoneNumber,
            interests: interests,
            places: places,
            about: about
        )

        switch updateMyResult {
        case .success(let baseResponse):
            if baseResponse.success, let data = baseResponse.data {
                return .success(data.toDomain())
            } else {
                return .failure(
                    RequestError.errorWithLog(
                        baseResponse.errorMessage ?? "Unknown error"
                    )
                )
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
