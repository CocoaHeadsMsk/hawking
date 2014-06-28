//
//  Grabber.swift
//  Hawking
//
//  Created by Dmitry Ponomarev on 28/06/14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import Foundation

class Grabber {

    func _loadData(url: String, success: (data: String) -> Void, failure: (error: NSError) -> Void) {
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

    func grabList(#url: String, success: (a:Array<AnyObject>) -> Void, failure: (err:NSError) -> Void) {
        if let listUrl = NSURL.URLWithString(url) {
            let manager = AFHTTPRequestOperationManager()
            manager.requestSerializer = AFHTTPRequestSerializer()
            manager.GET( "http://graph.facebook.com",
                parameters: nil,
                success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                    println("JSON: " + responseObject.description)
                },
                failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                    println("Error: " + error.localizedDescription)
                })
        }
    }

    func grabList(#txt: String, success: (a:Array<AnyObject>) -> Void, failure: (err:NSError) -> Void) {
        
    }
    
    ////////////////////////////////////////////////////////////////////////////
    // MARK: – Articles grabber
    ////////////////////////////////////////////////////////////////////////////
    
    func grabArticle(#url: String, success: (article: ArticleModel) -> Void, failure: (error: NSError) -> Void) {
        self._loadData(url,
            success: {data in
                self.grabArticle(text: data, success: success, failure: failure)
            }, failure: failure)
    }

    func grabArticle(#text: String, success: (article: ArticleModel) -> Void, failure: (error: NSError) -> Void) {
    }
}
