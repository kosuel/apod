//
//  apodTests.swift
//  apodTests
//
//  Created by ohhyung kwon on 9/6/2022.
//

import XCTest
@testable import apod

class apodTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSingleFetch() throws {
        
        // it is possible today's image is not ready
        let today = Date().start.addDays(-1)

        let expectation = self.expectation(description: "fetching")
        
        Apod.fetchApod(of: today) { apod in
            XCTAssertNotNil(apod)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testRangeFetch() throws {
        let today = Date().start.addDays(-1)
        let oneWeekBefore = today.addDays(-8)

        let expectation = self.expectation(description: "fetching")
        
        Apod.fetchApods(from: oneWeekBefore, to:today ) { apods in
            XCTAssertNotEqual(apods?.count, 0)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
