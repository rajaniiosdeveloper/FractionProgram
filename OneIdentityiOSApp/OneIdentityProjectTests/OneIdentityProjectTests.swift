//
//  OneIdentityProjectTests.swift
//  OneIdentityProjectTests
//
//  Created by Rajani on 04/09/23.
//

import XCTest
@testable import OneIdentityProject

final class OneIdentityProjectTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFractionFuctionCaseSuccess1() throws {
        let fractionResult = try IOFraction().processFraction(input: "1/2 * 3&3/4")
        let expectedValue = "1&7/8"
        XCTAssertEqual(expectedValue, fractionResult)
    }
    
    func testFractionFuctionCaseSuccess2() throws {
        let fractionResult = try IOFraction().processFraction(input: "2&3/8 + 9/8")
        let expectedValue = "3&1/2"
        XCTAssertEqual(expectedValue, fractionResult)
    }
    
    func testFractionFuctionCaseSuccess3() throws {
        let fractionResult = try IOFraction().processFraction(input: "1&3/4 - 2")
        let expectedValue = "-1/4"
        XCTAssertEqual(expectedValue, fractionResult)
    }
    
    func testFractionFuctionExpectError1() throws {
        do {
            let _ = try IOFraction().processFraction(input: " ")
            XCTFail("Expected error but didn't get one.")
        } catch IOFractionError.invalidInput {
            // This is the expected error.
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testFractionFuctionExpectError2() throws {
        do {
            let _ = try IOFraction().processFraction(input: "1/2 $ 5/6")
            XCTFail("Expected error but didn't get one.")
        } catch IOFractionError.invalidOperator {
            // This is the expected error.
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testFractionFuctionExpectError3() throws {
        do {
            let _ = try IOFraction().processFraction(input: "1/2 + @")
            XCTFail("Expected error but didn't get one.")
        } catch IOFractionError.undefinedError {
            // This is the expected error.
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
