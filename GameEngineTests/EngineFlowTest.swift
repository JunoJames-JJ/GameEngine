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
    
    let router = RouterSpy()
    
    func test_start_withNoQuestions_doesNotRouteToAnyQuestions(){
        makeSUT(questions: []).start ()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion(){
        makeSUT(questions: ["Q1"]).start ()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_2(){
        makeSUT(questions: ["Q2"]).start ()
        
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion(){
        makeSUT(questions: ["Q1", "Q2"]).start ()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    /*:  sut: System Under Test. */
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice(){
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start ()
        sut.start ()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_routesToSecondQuestion(){
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start ()
        
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routesToSecondAndThirdQuestion(){
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start ()
        
        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_doesNotRoutesToAnotherQuestion(){
        let sut = makeSUT(questions: ["Q1"])
        sut.start ()
        
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    /*:  Result test cases */

    func test_start_withNoQuestions_routesToResults(){
        makeSUT(questions: []).start ()
        
        XCTAssertEqual(router.routedResult!, [:])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_routesToResult(){
        let sut = makeSUT(questions: ["Q1"])
        sut.start ()
        
        router.answerCallback("A1")
        XCTAssertEqual(router.routedResult, ["Q1":"A1"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestions_routesToResult(){
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start ()
        
        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedResult, ["Q1":"A1", "Q2":"A2"])
    }
    
    // MARK: Helpers
    
    func makeSUT(questions: [String]) -> EngineFlow {
        return EngineFlow(questions: questions, router: router)
    }
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var routedResult: [String: String]? = nil

        var answerCallback: Router.AnswerCallback = {_ in }
        
        func routeTo(question: String, answerCallback: @escaping Router.AnswerCallback){
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: [String: String]) {
            routedResult = result
        }

        
    }
    
   
    
}

