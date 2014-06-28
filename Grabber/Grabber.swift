//
//  Grabber.swift
//  Hawking
//
//  Created by Dmitry Ponomarev on 28/06/14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import Foundation

class Grabber {
    
    func loadData(url: String, success: (data: String) -> Void, failure: (error: NSError) -> Void) {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.GET(url,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                success(data: operation.responseString)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                failure(error: error)
            })
    }
    
    func grabList(#url: String, success: (a:Array<AnyObject>) -> Void, failure: (error: NSError) -> Void) -> Void {
        self.loadData(url,
            success: { data in
                self.grabList(txt: data, success: success, failure: failure)
            },
            failure: failure
        )
    }
    
    func grabList(#txt: String, success: (a:Array<AnyObject>) -> Void, failure: (error: NSError) -> Void) -> Void {
        
    }
    
    func grabArticle(#url: String, success: (article: ArticleModel), failure: (error: NSError)) -> Bool {
        return false
    }
    
    func grabArticle(#text: String, success: (article: ArticleModel), failure: (error: NSError)) -> Bool {
        return false
    }
}
