//
//  Grabber.swift
//  Hawking
//
//  Created by Dmitry Ponomarev on 28/06/14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import Foundation

class Grabber {
  func _loadUrlData(url: String) {
  }
  
  func GrabList(url: String, success: (a:Array<AnyObject>), failure: (err:String)) -> Bool {
    return false
  }
  
  func GrabArticle(#url: String, success: (article: ArticleModel), failure: (err: String)) -> Bool {
    return false
  }
  
  func GrabArticle(#html: String, success: (article: ArticleModel), failure: (err: String)) -> Bool {
    return false
  }
}
