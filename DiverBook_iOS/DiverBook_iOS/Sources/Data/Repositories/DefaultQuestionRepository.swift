//
//  DefaultQuestionRepository.swift
//  DiverBook_iOS
//
//  Created by 배현진 on 5/6/25.
//

final class DefaultQuestionRepository: QuestionRepository {
    private var questionService: QuestionServicable
    
    init(
        questionService: QuestionServicable
    ) {
        self.questionService = questionService
    }
    
    func fetchQuestions(
        count: Int
    ) async -> Result<[Question], Error> {
        let fetchResult = await questionService.fetchQuestions(count: count)
        
        switch fetchResult {
        case .success(let baseResponse):
            if baseResponse.success, let data = baseResponse.data {
                let questions = data.toDomainList()
                return .success(questions)
            } else {
                let errorMessage = baseResponse.errorMessage ?? "Error"
                return .failure(RequestError.unknown)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
