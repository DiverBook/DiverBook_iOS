//
//  FetchDiverProfileUseCase.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/1/25.
//

protocol FetchDiverProfileUseCase {
    func executeFetchProfileImageUrl(nickName: String) async -> Result<String, Error>
    func executeFetchProfile(id: String) async -> Result<DiverProfile, Error>
    func executeFetchMyProfile() async -> Result<DiverProfile, Error>
}
