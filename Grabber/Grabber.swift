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
    
    func grabList(#url: String, success: (a:Array<ItemModel>) -> Void, failure: (err:NSError) -> Void) {
        if let listUrl = NSURL.URLWithString(url) {
            
        }
    }
    
    func grabList(#content: String, success: (a:Array<ItemModel>), failure: (err:NSError) -> Void) {
        
    }
    
    func grabArticle(#url: String, success: (article: ArticleModel) -> Void, failure: (error: NSError) -> Void) -> Bool {
        return false
    }
    
    func grabArticle(#content: String, success: (article: ArticleModel) -> Void, failure: (error: NSError) -> Void) -> Bool {
        return false
    }
}
