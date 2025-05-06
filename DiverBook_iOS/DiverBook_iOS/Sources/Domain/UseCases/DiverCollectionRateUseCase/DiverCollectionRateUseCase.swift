//
//  CollectionRateUseCase.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/6/25.
//

protocol DiverCollectionRateUseCase {
    func executeFetchDiverCollectionRate(id: String) async -> Result<Float, Error>
}
