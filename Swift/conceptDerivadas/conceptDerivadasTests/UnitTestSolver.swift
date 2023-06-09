//
//  UnitTestSolver.swift
//  conceptDerivadasTests
//
//  Created by Alumno on 09/06/23.
//

import XCTest
@testable import conceptDerivadas

final class UnitTestSolver: XCTestCase {
    var problemsCR:[ChainRule]!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //TBD
        problemsCR.append(ChainRule(polynomial: Polynomial(terms: [Term(coefficient: Fraction(numerator: 1, denominator: 1), exponent: Fraction(numerator: 1, denominator: 1)), Term(coefficient: Fraction(numerator: 2, denominator: 1), exponent: Fraction(numerator: 0, denominator: 1))]), exponent: Fraction(numerator: 2, denominator: 1)))
        problemsCR.append(ChainRule(polynomial: Polynomial(terms: [Term(coefficient: Fraction(numerator: 1, denominator: 1), exponent: Fraction(numerator: 1, denominator: 1)), Term(coefficient: Fraction(numerator: 2, denominator: 1), exponent: Fraction(numerator: 0, denominator: 1))]), exponent: Fraction(numerator: 2, denominator: 1)))
        problemsCR.append(ChainRule(polynomial: Polynomial(terms: [Term(coefficient: Fraction(numerator: 1, denominator: 1), exponent: Fraction(numerator: 1, denominator: 1)), Term(coefficient: Fraction(numerator: 2, denominator: 1), exponent: Fraction(numerator: 0, denominator: 1))]), exponent: Fraction(numerator: 2, denominator: 1)))
        problemsCR.append(ChainRule(polynomial: Polynomial(terms: [Term(coefficient: Fraction(numerator: 1, denominator: 1), exponent: Fraction(numerator: 1, denominator: 1)), Term(coefficient: Fraction(numerator: 2, denominator: 1), exponent: Fraction(numerator: 0, denominator: 1))]), exponent: Fraction(numerator: 2, denominator: 1)))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIntExponent() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//        ForEach(0 ..< problemsCR.count) { value in
//                    Text(deckColors[value].name)
//                }
//        XCTAssertEqual(problem[].diffString(), "2(x+2)")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
