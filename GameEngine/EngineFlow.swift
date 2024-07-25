//
//  EngineFlow.swift
//  GameEngine
//
//  Created by Juno James on 2024-07-24.
//

import Foundation

/*: Router: This is a type that we are going to communicate. */
protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
    func routeTo(result: [String: String])
}


/*:  EngineFlow: Shows the Flow. */
class EngineFlow {
   private let router: Router
   private let questions: [String]
    
    private var result: [String: String] = [:]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    /*: Only 'start()' method needs to be public.
     i.e, the beahviour of this class is tested through this single interface.
     */
    func start(){
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(from: firstQuestion))
        } else {
            router.routeTo(result: result)
        }
    }
    
   private func routeNext(from question: String)-> Router.AnswerCallback {
        return {[weak self] answer in
            guard let strongSelf = self else { return }
            
            if let currentQuestionIndex = strongSelf.questions.firstIndex(of: question) {
                strongSelf.result[question] = answer

                if currentQuestionIndex+1 < strongSelf.questions.count {
                    let nextQuestion = strongSelf.questions[currentQuestionIndex+1]
                    strongSelf.router.routeTo(question: nextQuestion, answerCallback: strongSelf.routeNext(from: nextQuestion))
                } else {
                    strongSelf.router.routeTo(result: strongSelf.result)

                }
            }
        }
    }
}
