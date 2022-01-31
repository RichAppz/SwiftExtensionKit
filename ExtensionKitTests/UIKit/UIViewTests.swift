//
//  UIViewTests.swift
//  ServiceCoreTests
//
//  Created by Shruti on 3/30/20.
//  Copyright © 2020 Rich Mucha. All rights reserved.
//

import XCTest

class UIViewTests: XCTestCase {
    
    //==================================================
    // MARK: Properties
    //==================================================
    
    let view = UIView()
    
    //==================================================
    // MARK: Setup
    //==================================================
    
    override func setUp() {
        super.setUp()
        view.frame = CGRect(x: 10, y: 10, width: 100, height: 50)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //==================================================
    // MARK: Tests
    //==================================================
    
    func testFadeInView() {
        let expectation = self.expectation(description: "animation")
        view.fadeIn(time: 0.2, alpha: 0.7) {
            XCTAssert(self.view.alpha <= 0.7)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            print(error as Any)
        }
    }
    
    func testFadeOutView() {
        let expectation = self.expectation(description: "animation")
        view.fadeOut(time: 0.2, alpha: 0.7) {
            XCTAssert(self.view.alpha <= 0.7)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            print(error as Any)
        }
    }
    
    func testAddShadow() {
        let opacity: Float = 0.5
        let radius: CGFloat = 10
        let height: CGFloat = 10
        let color: UIColor = .black
        
        view.addShadow(opacity: opacity, radius: radius, height: height, color: color)
        
        XCTAssert(view.layer.shadowRadius == radius)
        XCTAssert(view.layer.shadowOpacity == opacity)
        XCTAssert(view.layer.shadowOffset.height == height)
        XCTAssert(view.layer.shadowColor == color.cgColor)
    }
    
    func testRemoveShadow() {
        view.removeShadow()
        XCTAssert(view.layer.shadowOffset.height == 0.0)
        XCTAssert(view.layer.shadowColor == UIColor.clear.cgColor)
    }
    
    func testDottedLine() {
        let color: UIColor = .blue
        let width: CGFloat = 2
        view.applyDottedLine(width: width, color: color)
        
        let shapeLayer: CAShapeLayer? = view.layer.sublayers?[0] as? CAShapeLayer ?? CAShapeLayer()
        XCTAssert(view.layer.sublayers?.count ?? 0 > 0)
        XCTAssert(shapeLayer?.strokeColor == color.cgColor)
        XCTAssert(shapeLayer?.lineWidth == width)
    }
    
    func testBorder() {
        let color: UIColor = .black
        let width: CGFloat = 1
        view.applyBorder(color: color.cgColor, width: width)
        
        XCTAssert(view.layer.borderColor == color.cgColor)
        XCTAssert(view.layer.borderWidth == width)
    }
    
    //==================================================
    // MARK: Origins
    //==================================================
    
    func testOrigin() {
        var point = CGPoint()
        point = view.origin
        XCTAssert(view.frame.origin == point)
        
        view.origin.x = 20.0
        view.origin.y = 30.0
        point = view.origin
        XCTAssert(view.frame.origin == point)
    }
    
    func testOriginX() {
        var xValue = CGFloat()
        xValue = view.originX
        XCTAssert(xValue == view.frame.origin.x)
    }
    
    func testOriginY() {
        var yValue = CGFloat()
        yValue = view.originY
        XCTAssert(yValue == view.frame.origin.y)
    }
    
    //==================================================
    // MARK: Size
    //==================================================
    
    func testSize() {
        var size = CGSize()
        size = view.size
        XCTAssert(view.frame.size == size)
        
        view.frame.size.width = 150.0
        view.frame.size.width = 50.0
        size = view.frame.size
        
        XCTAssert(view.frame.size == size)
    }
    
    //==================================================
    // MARK: Edges
    //==================================================
    
    func testBottomEdge() {
        XCTAssert(view.bottomEdge == view.origin.y + view.frame.height)
    }
    
    func testRightEdge() {
        XCTAssert(view.rightEdge == view.origin.x + view.frame.width)
    }
    
}
