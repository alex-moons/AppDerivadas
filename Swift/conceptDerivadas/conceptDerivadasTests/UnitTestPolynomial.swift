//
//  UnitTestPolynomial.swift
//  conceptDerivadas
//
//  Created by Alumno on 02/06/23.
//

import XCTest
@testable import conceptDerivadas

final class UnitTestPolynomial: XCTestCase {
    
    var sut : Polynomial!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        var newPoly = Polynomial(terms: [Term]())
        newPoly.generate(minVal: 0, maxVal: 9, degree: 4)
        print(newPoly.toString())
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
