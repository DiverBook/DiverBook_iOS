//
//  DefaultFetchQuestionUseCase.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/6/25.
//

final class DefaultFetchQuestionUseCase: FetchQuestionUseCase {
    private let repository: QuestionRepository
    
    init(repository: QuestionRepository) {
        self.repository = repository
    }
    
    func executeFetchQuestion(count: Int) async -> Result<[Question], Error> {
        return await repository.fetchQuestions(count: count)
    }
}
