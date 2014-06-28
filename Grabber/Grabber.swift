//
//  Grabber.swift
//  Hawking
//
//  Created by Dmitry Ponomarev on 28/06/14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import Foundation

class Grabber {
    func GrabList(input: String, success: (a:Array<AnyObject>), failure: (err:NSError)) -> Bool {
        
        
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
            

        
        if input.hasPrefix("http") {
            grabNewsList(input, success: success, failure: failure)
        } else {
            grabNewsListContent(input, success: success, failure: failure)
        }
        
        
//        success(a: <#Array<AnyObject>#>)
//        failure(err: <#String#>)
        
        
        return false
    }
    
    func grabNewsList(url: String, success: (a:Array<AnyObject>), failure: (err:NSError)) {
        if let listUrl = NSURL.URLWithString(url) {
            
        }
    }
    
    func grabNewsListContent(content: String, success: (a:Array<AnyObject>), failure: (err:NSError)) {
        
    }
}
