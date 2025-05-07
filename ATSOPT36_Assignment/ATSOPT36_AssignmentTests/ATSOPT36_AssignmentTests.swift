//
//  ATSOPT36_AssignmentTests.swift
//  ATSOPT36_AssignmentTests
//
//  Created by 권석기 on 5/4/25.
//

import XCTest

@testable import ATSOPT36_Assignment

final class ATSOPT36_AssignmentTests: XCTestCase {
    
    let sut = LoginViewController()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_textFieldInput_validEmailFormat() {
        // Given
           sut.loadViewIfNeeded()
           sut.idTextField.text = "example.com"

           // When
           let input = sut.idTextField.text ?? ""

           // Then
           XCTAssertTrue(input.isValidEmail, "이메일 형식이 아님")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
