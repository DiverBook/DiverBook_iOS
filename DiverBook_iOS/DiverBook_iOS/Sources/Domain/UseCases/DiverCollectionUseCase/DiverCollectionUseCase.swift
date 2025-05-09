//
//  DiverCollectionUseCase.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/6/25.
//

protocol DiverCollectionUseCase {
    func executeFetchAllDiverList() async -> Result<[DiverProfile], Error>
    func executeFetchDiverCollection() async -> Result<[CollectedDiverInfo], Error>
}
