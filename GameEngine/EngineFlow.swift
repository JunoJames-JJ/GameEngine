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
            router.routeTo(question: firstQuestion, answerCallback: nextCallback(from: firstQuestion))
        } else {
            router.routeTo(result: result)
        }
        //..
    }
    
    private func nextCallback(from question: String)-> Router.AnswerCallback {
        return { [weak self] in self?.routeNext(question, $0) }
    }
    
    private func routeNext(_ question: String, _ answer: String) {
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            result[question] = answer
            let nextQuestionIndex = currentQuestionIndex+1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
            } else {
                router.routeTo(result: result)
            }
            //..
        }
    }
}
