//
//  IntFunctionsTests.swift
//  ServiceCoreTests
//
//  Created by Shruti on 4/1/20.
//  Copyright © 2020 Rich Mucha. All rights reserved.
//

import XCTest

class IntFunctionsTests: XCTestCase {
    
    //==================================================
    // MARK: Setup
    //==================================================
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //==================================================
    // MARK: Tests
    //==================================================
    
    func testUnitCurrencyString() {
        XCTAssert(1.getLocalisedCurrencyString(currencyCode: "GBP") == "£0.01")
        XCTAssert(20.getLocalisedCurrencyString(currencyCode: "GBP") == "£0.20")
        XCTAssert(1905.getLocalisedCurrencyString(currencyCode: "GBP") == "£19.05")
        XCTAssert(1000000.getLocalisedCurrencyString(currencyCode: "GBP") == "£10,000.00")
        
        XCTAssert(20.getLocalisedCurrencyString(currencyCode: "INR") == "₹0.20")
    }
    
}
