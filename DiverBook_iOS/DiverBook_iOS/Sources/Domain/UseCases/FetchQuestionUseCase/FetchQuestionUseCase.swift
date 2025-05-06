//
//  FetchQuestionUseCase.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/6/25.
//

protocol FetchQuestionUseCase {
    func executeFetchQuestion(count: Int) async -> Result<[Question], Error>
}
