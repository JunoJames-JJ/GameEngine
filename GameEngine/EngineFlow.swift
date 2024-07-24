//
//  EngineFlow.swift
//  GameEngine
//
//  Created by Juno James on 2024-07-24.
//

import Foundation

protocol Router {
    func routeTo(question: String)
}

class EngineFlow {
    let router: Router
    let questions: [String]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start(){
        if !questions.isEmpty {
            router.routeTo(question: "")
        }
    }
    
}
