//
//  CollectionRepository.swift
//  DiverBook_iOS
//
//  Created by 한건희 on 5/6/25.
//

protocol DiverCollectionRepository {
    func fetchAllDiverList() async -> Result<[DiverProfile], Error>
    func fetchDiverCollection() async -> Result<[DiverProfile], Error>
}
