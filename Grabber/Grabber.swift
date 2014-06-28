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
        manager.requestSerializer.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10) AppleWebKit/538.39.41 (KHTML, like Gecko) Version/8.0 Safari/538.39.41", forHTTPHeaderField: "User-Agent")
        manager.GET(url,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                success(data: operation.responseString)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                failure(error: error)
            })
    }
    
<<<<<<< HEAD
    func grabList(#url: String, success: (a: Array<AnyObject>) -> Void, failure: (error: NSError) -> Void) -> Void {
        self._loadData(url,
            success: { data in
                self.grabList(txt: data, success: success, failure: failure)
            },
            failure: failure
        )
    }
    
    func grabList(#txt: String, success: (a: Array<AnyObject>) -> Void, failure: (error: NSError) -> Void) -> Void {
        let htmlData = txt.dataUsingEncoding(NSUTF8StringEncoding)
        let aHpple = TFHpple.hppleWithHTMLData(htmlData)
        
        if let domTree: Array = aHpple.searchWithXPathQuery("//body") {
            let qw = domTree[0] as TFHppleElement
            println(qw)
        }
//        self.parseList(domTree)
        success(a: [])
    }
    
    func parseList(domTree: Array<AnyObject>) {
=======
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
>>>>>>> FETCH_HEAD
        
    }
    
    func grabArticle(#url: String, success: (article: ArticleModel), failure: (error: NSError)) -> Bool {
        return false
    }
    
    func grabArticle(#text: String, success: (article: ArticleModel), failure: (error: NSError)) -> Bool {
        return false
    }
}
