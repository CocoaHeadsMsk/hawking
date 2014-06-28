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
    XCTAssert(grabber.GrabList(url: listGrabTestURL, success: {list as
      
      }, failure: {error in
        
      }), "Invalid grab list")
  }
  
  func testArticle() {
    XCTAssert(grabber.GrabArticle(url: articleGrabTestURL, success:{article in
    
      } failure: {err in
        
      }), "Invalid grab article")
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measureBlock() {
        // Put the code you want to measure the time of here.
    }
  }
    
}
