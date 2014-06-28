//
//  Cache.swift
//  Hawking
//
//  Created by Магомед Чапанов on 28.06.14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import Foundation

class Cache {
    
    var cache = Article[]();
    
    
    
    func isInCache(#url: String) -> String?{
        var inCache:String?
        for article in self.cache {
            if article.URL.bridgeToObjectiveC().containsString(url)
            {
                inCache = article
            }
        }
        return inCache
    }
    
    
    func grubArticleFromCache(#url: String, success: (a:Array<AnyObject>) -> Void, failure: (err:NSError) -> Void) {
        
        if !isInCache(url: url) {
            //   Grabber.grabList(url: url)
        }else{
            
        }
        
        returnArticle(url: url)
    }
    
    func returnArticle(#url: String) -> String?{
        for article in self.cache {
            if article.bridgeToObjectiveC().containsString(url)
            {
                return article
            }
        }
        return nil
    }
    
}