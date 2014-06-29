//
//  GrabberTests.swift
//  GrabberTests
//
//  Created by Dmitry Ponomarev on 28/06/14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import XCTest

class GrabberTests: XCTestCase {
    
    let listGrabTestURL = "http://habrahabr.ru"
    let articleGrabTestURL = "http://habrahabr.ru/post/227911/"
    
    var grabber: Grabber?
    
    override func setUp() {
        super.setUp()
        grabber = Grabber()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testList() {
        grabber.grabList(url: listGrabTestURL, success: {list as
            
            }, failure: {error in
                
            })
        XCTAssert(true, "Invalid grab list")
    }
    
    func testContentList() {
        grabber.grabList(input: "sadasdsa", success: {list as
            
            }, failure: {error in
                
            })
        XCTAssert(true, "Invalid grab list")
    }
    
    func testArticle() {
        grabber.grabArticle(url: articleGrabTestURL, success:{article in
            
            } failure: {err in
                
            })
        XCTAssert(false, "Invalid grab article")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
