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

    func grabList(input: String, success: (a:Array<AnyObject>) -> Void, failure: (err:NSError) -> Void) -> Bool {
        let manager = AFHTTPRequestOperationManager()
        manager.requestSerializer.setValue("608c6c08443c6d933576b90966b727358d0066b4", forHTTPHeaderField: "X-Auth-Token")
          
            manager.GET( "http://graph.facebook.com",
                parameters: nil,
                success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                    println("JSON: " + responseObject.description)
                },
                failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                    println("Error: " + error.localizedDescription)
                })
            

        return false


        if input.hasPrefix("http") {
            grabNewsList(url: input, success: success, failure: failure)
        } else {
            grabNewsList(content: input, success: success, failure: failure)
        }
        
        
//        success(a: Array<AnyObject>)
//        failure(err: String)
        
        
        return false
    }
    
    func grabNewsList(#url: String, success: (a:Array<AnyObject>) -> Void, failure: (err:NSError) -> Void) {
        if let listUrl = NSURL.URLWithString(url) {
            
        }
    }
    
    func grabNewsList(#content: String, success: (a:Array<AnyObject>) -> Void, failure: (err:NSError) -> Void) {
        
    }
    
    func grabArticle(#url: String, success: (article: ArticleModel), failure: (error: NSError)) -> Bool {
        return false
    }
    
    func grabArticle(#text: String, success: (article: ArticleModel), failure: (error: NSError)) -> Bool {
        return false
    }
}
