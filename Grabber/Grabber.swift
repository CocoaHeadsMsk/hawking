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
    
    func _loadData(url: String, success: (data: String) -> Void, failure: (error: NSError) -> Void) {
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
    
    ////////////////////////////////////////////////////////////////////////////
    // MARK: – Grab List
    ////////////////////////////////////////////////////////////////////////////

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
        //let aHpple = TFHpple.hppleWithHTMLData(htmlData)
        

        var par = XMLDictionaryParser.sharedInstance()
        var dic = par.dictionaryWithData(htmlData)
        var arr = dic.arrayValueForKeyPath("channel.item")

        
        for item: AnyObject in arr {
            if let it = item as? NSDictionary {
                println(it["link"])

            }
        }
        
        
        
        
//        if let domTree: Array = aHpple.searchWithXPathQuery("//rss/channel") {
////            println(domTree)
//            if domTree.count > 0 {
//                self.parseList(domTree)
//            }
////            let qw = domTree[0] as TFHppleElement
////            println(qw)
//        }
//        success(a: [])
    }
    
    func parseList(domTree: Array<AnyObject>) {
        self.each(domTree[0] as TFHppleElement, level: 0, { level, el in
            
            if let tag = el.tagName {
                switch tag {
                case "item":
                    return true
//                    println(el.raw)
                case "title":
                    println(el.raw)
                case "link":
                    println(el.content)
                case "description":
                    println(el)
                default:
//                    println(el.raw)
                    break
                }
            }
            
            return false
        })
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
