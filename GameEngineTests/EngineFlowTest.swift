//
//  EngineFlowTest.swift
//  GameEngineTests
//
//  Created by Juno James on 2024-07-24.
//

import Foundation
import XCTest
@testable import GameEngine


class EngineFlowTest: XCTestCase {
    
    func test_start_withNoQuestions_doesNotRouteToAnyQuestions(){
        let router = RouterSpy()
        let sut = EngineFlow(questions: [], router: router)
        sut.start ()
        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func test_start_withOneQuestion_routesToQuestion(){
        let router = RouterSpy()
        let sut = EngineFlow(questions: ["Q1"], router: router)
        sut.start ()
        XCTAssertEqual(router.routedQuestionCount, 1)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion(){
        let router = RouterSpy()
        let sut = EngineFlow(questions: ["Q1"], router: router)
        sut.start ()
        XCTAssertEqual(router.routedQuestion, "Q1")
    }
    
    
    
    class RouterSpy: Router {
        var routedQuestionCount: Int = 0
        var routedQuestion: String? = nil
        
        func routeTo(question: String) {
            routedQuestionCount += 1
            routedQuestion = question
        }
        
    }
    
   
    
}

