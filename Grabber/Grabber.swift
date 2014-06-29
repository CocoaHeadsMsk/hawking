//
//  Grabber.swift
//  Hawking
//
//  Created by Dmitry Ponomarev on 28/06/14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import Foundation

struct TextBlockCost {
    var domElement: TFHppleElement
    var blockCount: Int
    var contentSize: Int
}

class Grabber {
    
    var baseUrl = ""
    
    func _loadData(url: String, success: (data: String) -> Void, failure: (error: NSError) -> Void) {
        
        let manager = AFHTTPRequestOperationManager()
        let u1 = NSURL(string: url)
        
        if let u2 = u1.absoluteString {
            if u2.hasPrefix("http") {
                self.baseUrl = u2
            }
        }

        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10) AppleWebKit/538.39.41 (KHTML, like Gecko) Version/8.0 Safari/538.39.41", forHTTPHeaderField: "User-Agent")
        manager.GET(url,
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                success(data: operation.responseString)
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                if nil != failure {
                    failure(error: error)
                }
            })
    }
    
    ////////////////////////////////////////////////////////////////////////////
    // MARK: – Grab List
    ////////////////////////////////////////////////////////////////////////////

    func fetchRss(pageContent: String, success: (rssUrl: String) -> Void, failure: (error: NSError) -> Void) -> Void {
        
//  <link rel="alternate" type="application/rss+xml" title="Example" href="http://www.aweber.com/blog/feed/" />
        
        var data = pageContent.dataUsingEncoding(NSUTF8StringEncoding)
        let doc = TFHpple.hppleWithHTMLData(data)
        let list = doc.searchWithXPathQuery("//html/head")
        

        
        var rssUrl = ""
        
        if list.count > 0 {
            self._each(list[0] as TFHppleElement, level: 0, { level, el in
                if let tag = el.tagName {
                    
                    switch tag {
                    case "link":
                        if let attr = el.attributes {
                            if let at = attr["type"] as? String {
                                if let link = attr["href"] as? String {
                                        if at == "application/rss+xml" {
                                            if link.hasPrefix("http") {
                                                rssUrl = link
                                                success(rssUrl: rssUrl)
                                            } else {
                                                var u = NSURL(string: link, relativeToURL: NSURL(string: self.baseUrl))
                                                rssUrl = u.absoluteString
                                                success(rssUrl: rssUrl)
                                            }
                                    }
                                }
                            }
                        }
                    default:
                        break
                    }
                }
                return false
                })
        }
    }
    
    func grabList(#url: String, success: (a: Array<AnyObject>) -> Void, failure: (error: NSError) -> Void) -> Void {
        self._loadData(url,
            success: { data in
                self.fetchRss(data, success: { rssUrl in
                    self._loadData(rssUrl, success: { rssContent in
                        self.grabList(txt: rssContent, success: success, failure: failure)
                        },
                        failure: failure
                    )
                    },
                    failure: failure)
            },
            failure: failure
        )
    }
    
    func grabList(#txt: String, success: (a: Array<AnyObject>) -> Void, failure: (error: NSError) -> Void) -> Void {
        let htmlData = txt.dataUsingEncoding(NSUTF8StringEncoding)

        var par = XMLDictionaryParser.sharedInstance()
        var dic = par.dictionaryWithData(htmlData)
        var arr = dic.arrayValueForKeyPath("channel.item")

        if nil == arr {
            failure(error: NSError(domain: "", code: 0, userInfo: ["msg":"Invalid array"]))
            
        } else {
            success(a: arr)
        }
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
        var data = text.dataUsingEncoding(NSUTF8StringEncoding)
        let doc = TFHpple.hppleWithHTMLData(data)
        let list = doc.searchWithXPathQuery("//body")

        if list.count > 0 {
            // Information about text blocks
            var blocks = Dictionary<String, TextBlockCost>()
            
            // Each HTML tree
            self.each(list[0] as TFHppleElement, level: 0, { level, el in
                if let tag = el.tagName {
//                    print(level)
//                    print(" -> ")
//                    println(el.tagName)
                    switch tag {
                    case "p":
                        fallthrough
                    case "pre":
                        fallthrough
                    case "p", "pre", "code":
//                        print(" @@@@-> ")
//                        print(self.pathFor(el))
//                        print(" -> ")
//                        println(el.raw)
                        
                        var blockPath = self.pathFor(el.parent)
                        
                        if let bc = blocks[blockPath] {
                            var bc2 = bc
                            bc2.blockCount++
                            bc2.contentSize += self.cleanHtml(el.raw).utf16count
                            blocks[blockPath] = bc2
                        } else {
                            blocks[blockPath] = TextBlockCost(domElement: el.parent,
                                blockCount: 1, contentSize: self.cleanHtml(el.raw).utf16count)
                        }
                        return false
                    case "script":
                        fallthrough
                    case "text":
                        fallthrough
                    case "comment":
                        return false
                    default:
//                        println(el.content)
                        break
                    }
                }
                return true
            })
            
            for (k, b) in blocks {
                print(k)
                print(" >> ")
                print(b.blockCount)
                print(", ")
                print(b.contentSize)
                print(" >>>>> ")
                print(b.domElement.raw)
                println("")
            }
        }
    }
    
    
    ////////////////////////////////////////////////////////////////////////////
    // MARK: – Site info
    ////////////////////////////////////////////////////////////////////////////
    
//    func grabSiteInfo(#url: String, success: (info: SiteInfoModel) -> Void, failure: (error: NSError) -> Void) {
//        
//    }
    
    ////////////////////////////////////////////////////////////////////////////
    // MARK: – Helpers
    ////////////////////////////////////////////////////////////////////////////

    func each(elem: TFHppleElement, level: Int, fn: (level: Int, el: TFHppleElement) -> Bool) {
        for it : AnyObject in elem.children {
            if let item = it as? TFHppleElement {
                if fn(level: level, el: item) {
                    each(item, level: level + 1, fn: fn)
                }
            }
        }
    }
    
    func cleanHtml(text: String) -> String {
        return text
    }
    
    func pathFor(elem: TFHppleElement) -> String {
        var el = elem
        var path: String = complexNameFor(el)
        while nil != el.parent {
            el = el.parent
            path = complexNameFor(el) + "." + path
        }
        return path
    }
    
    func complexNameFor(elem: TFHppleElement) -> String {
        var el = elem
        var name: String = el.tagName
        return name
    }
    
    func articleBlock(blocks: Array<TextBlockCost>) -> TextBlockCost {
        var block = blocks[0]
        for b in blocks {
            if b.contentSize > block.contentSize {
                block = b
            }
        }
        return block
    }
}
