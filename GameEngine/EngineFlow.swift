//
//  EngineFlow.swift
//  GameEngine
//
//  Created by Juno James on 2024-07-24.
//

import Foundation

protocol Router {
    func routeTo(question: String, answerCallback: @escaping (String) -> Void)
}

class EngineFlow {
    let router: Router
    let questions: [String]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start(){
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion) { [weak self] _ in
                guard let strongself = self else { return }
                let firstQuestionIndex = strongself.questions.firstIndex(of: firstQuestion)!
                let nextQuestion = strongself.questions[firstQuestionIndex + 1]
                strongself.router.routeTo(question: nextQuestion) {_ in}
            }
        }
    }
    
}
