//
//  ItemModel.swift
//  Hawking
//
//  Created by Dmitry Ponomarev on 28/06/14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import Foundation

class ItemModel {
    var title: String = ""
    var publisher: String = ""
    var date: NSDate?
    var description: String = ""
    var tags: Array<String>?
    var images: Array<String>?

    var sourceUrl: String = ""
  
    init() {}
}
