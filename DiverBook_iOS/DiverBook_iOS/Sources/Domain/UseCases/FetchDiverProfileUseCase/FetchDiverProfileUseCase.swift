//
//  FetchDiverProfileUseCase.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/1/25.
//

protocol FetchDiverProfileUseCase {
    func executeFetchProfile(id: String) async -> Result<DiverProfile, Error>
}
