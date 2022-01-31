//
//  StringFunctionsTests.swift
//  ServiceCoreTests
//
//  Created by Shruti on 3/30/20.
//  Copyright © 2020 Rich Mucha. All rights reserved.
//

import XCTest

class StringFunctionsTests: XCTestCase {
    
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
    
    func testStringFont() {
        let size: CGFloat = 12.0
        let font = "Test".fontFromString(size: size)
        
        XCTAssert(font.pointSize == size)
    }
    
    func testIsValidEmail() {
        let validEmails = [
            "test@gmail.com",
            "fname.lname@example.com",
            "test@subdomain.test.com",
            "1234567890@example.com",
            "value@example.name",
            "test1-test2@mail.com"
        ]
        
        validEmails.forEach { mail in
            XCTAssertTrue(mail.isValidEmail)
        }
    }
    
    func testInvalidEmail() {
        let inValidEmails = [
            "testgmail.com",
            "test",
            "testgmailcom",
            "testgmail@com",
            "test@@gmailcom",
            "test@@gmail.com",
            "test@gmailcom",
            ".test@mail.com",
            "test.@mail.com"
        ]
        
        for mail in inValidEmails {
          XCTAssertTrue(!mail.isValidEmail)
        }
    }
    
    func testHeight() {
        let str = "Testing"
        let font = UIFont.systemFont(ofSize: 3.0)
        
        var calculatedValue = CGFloat()
        calculatedValue = str.height(withConstrainedWidth: CGFloat.greatestFiniteMagnitude, font: font)
        XCTAssert(calculatedValue > font.pointSize)
        XCTAssert(calculatedValue > 0.0)
    }
    
    func testwidth() {
        let str = "Testing"
        let font = UIFont.systemFont(ofSize: 2)
        
        var calculatedValue = CGFloat()
        calculatedValue = str.width(withConstrainedHeight: CGFloat.greatestFiniteMagnitude, font: font)
        XCTAssert(calculatedValue > font.pointSize)
        XCTAssert(calculatedValue > 0.0)
        
    }
    
}
