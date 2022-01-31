//
//  DateFunctionsTests.swift
//  ServiceCoreTests
//
//  Created by Shruti on 4/1/20.
//  Copyright © 2020 Rich Mucha. All rights reserved.
//

import XCTest

class DateFunctionsTests: XCTestCase {
    
    //==================================================
    // MARK: Properties
    //==================================================
    
    var today: Date?
    
    //==================================================
    // MARK: Setup
    //==================================================
    
    override func setUp() {
        super.setUp()
        today = Date()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    //==================================================
    // MARK: Tests
    //==================================================
    
    func testSameDay() {
        let yesterday: Date? = Calendar.current.date(byAdding: .day, value: -1, to: today ?? Date())
        let isSameDay = yesterday?.isSameDayAs(today ?? Date()) ?? false
        XCTAssertTrue(!isSameDay)
    }
    
    func testEndOfMonth() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
     
        let date1 = formatter.date(from: "12-02-2020") ?? Date()
        let date2 = formatter.date(from: "27-01-2020") ?? Date()
        let date3 = formatter.date(from: "14-11-2020") ?? Date()
        
        let comp1 = Calendar.current.component(.day, from:date1.endOfMonth ?? Date())
        let comp2 = Calendar.current.component(.day, from:date2.endOfMonth ?? Date())
        let comp3 = Calendar.current.component(.day, from:date3.endOfMonth ?? Date())

        XCTAssert(today != nil)
        XCTAssert(comp1 == 29)
        XCTAssert(comp2 == 31)
        XCTAssert(comp3 == 30)
    }
    
    func testStartOfMonth() {
        today = today?.startOfMonth ?? Date()
        let dateComp = Calendar.current.component(.day, from: today ?? Date())
        XCTAssert(today != nil)
        XCTAssert(dateComp == 1)
    }
    
    func testYear() {
        let yearValue: Int = today?.year ?? 0
        let yearFromDate = Calendar.current.component(.year, from: today ?? Date())
        XCTAssert(yearFromDate == yearValue)
    }
    
    func testDay() {
        let dayValue: Int = today?.day ?? 0
        let dayFromDate = Calendar.current.component(.day, from:today ?? Date())
        XCTAssert(dayFromDate == dayValue)
    }
    
}
