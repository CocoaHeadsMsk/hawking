//
//  Grabber.swift
//  Hawking
//
//  Created by Dmitry Ponomarev on 28/06/14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import Foundation

struct TextBlockCost {
    var path: String
    var domElement: TFHppleElement
    var blockCount: Int
    var contentSize: Int
    var index: Int
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
                self.grabArticle(text: data, url: url, success: success, failure: failure)
            }, failure: failure)
    }
    
    func grabArticle(#text: String, url: String, success: (article: ArticleModel) -> Void, failure: (error: NSError) -> Void) {
        var data = text.dataUsingEncoding(NSUTF8StringEncoding)
        let doc = TFHpple.hppleWithHTMLData(data)
        let list = doc.searchWithXPathQuery("//body")
        var titleList = doc.searchWithXPathQuery("//html/head/title")
        var title: String = ""

        if titleList.count > 0 {
            title = _cleanHtml((titleList[0] as TFHppleElement).raw)
        }

        if list.count > 0 {
            // Information about text blocks
            var blocks = Dictionary<String, TextBlockCost>()
            
            // Display none regexp
            var hiddenBlock = NSRegularExpression.regularExpressionWithPattern("(^|;)\\s*display\\s*:\\snone($|;|\\s)",
                options:NSRegularExpressionOptions.CaseInsensitive, error: nil)
            
            // Each HTML tree
            self._each(list[0] as TFHppleElement, level: 0, { level, el in
                // Check CSS
                if let _style: AnyObject = el.attributes["style"] {
                    var style = _style as String
                    if hiddenBlock.numberOfMatchesInString(style, options: NSMatchingOptions.Anchored, range: NSRange(location: 0, length: style.utf16count)) > 0 {
                        return false
                    }
                }
                
                // Check tags
                if let tag = el.tagName {
                    switch tag {
                    case "p", "pre", "code", "h1", "h2", "h3", "h4", "h5":
                        var elm = self._baseLevelFor(el)
                        var blockPath = self._pathFor(elm)
                        
                        if let bc = blocks[blockPath] {
                            var bc2 = bc
                            bc2.blockCount++
                            bc2.contentSize += self._cleanHtml(elm.raw).utf16count
                            blocks[blockPath] = bc2
                        } else {
                            var contentSize = self._cleanHtml(elm.raw).utf16count
                            if contentSize > elm.raw.utf16count/3 {
                                blocks[blockPath] = TextBlockCost(path: blockPath, domElement: elm,
                                    blockCount: 1, contentSize: contentSize, index: blocks.count)
                            }
                        }
                        return false
                    case "script", "text", "comment", "header", "footer":
                        return false
                    default:
                        break
                    }
                }
                return true
            })
            
            var blocksArr = Array<TextBlockCost>()
            
            // Dictionary to array
            for (k, b) in blocks { /*print(String(b.index)+" > "+String(b.contentSize)); println(" "+k+"! ");*/ blocksArr.append(b) }
            
            // Sort by index
            blocksArr.sort({$0.index > $1.index})
            
            // Prepare list of blocks
            blocksArr = self._prepareArticleBlocks(blocksArr)
            blocksArr.sort({$0.contentSize > $1.contentSize})
            
            // Get base article block
            self._grabArticle(blocksArr, title: title, url: url, success: success, failure: failure)
        }
    }
    
    func _grabArticle(list: Array<TextBlockCost>, title: String, url: String, success: (article: ArticleModel) -> Void, failure: (error: NSError) -> Void) {
        var article = ArticleModel()
        article.title = title
        article.sourceUrl = url

        for block in list {
            if self._parseArticleFromHtml(block.domElement, article: &article) {
                println("########## " + String(block.index)+" > "+String(block.contentSize))
                success(article: article)
                return
            }
        }
        failure(error: NSError(domain: "", code: 0, userInfo: ["msg":"Invalid article grab"]))
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

    func _each(elem: TFHppleElement, level: Int, fn: (level: Int, el: TFHppleElement) -> Bool) {
        for it : AnyObject in elem.children {
            if let item = it as? TFHppleElement {
                if fn(level: level, el: item) {
                    _each(item, level: level + 1, fn: fn)
                }
            }
        }
    }
    
    func _parseArticleFromHtml(doc: TFHppleElement, inout article: ArticleModel) -> Bool {
        var title = doc.firstChildWithTagName("h1")
        if nil != title {
            var range = doc.raw.rangeOfString(title.raw, options: NSStringCompareOptions.AnchoredSearch, range: nil, locale: nil)
            article.content = _simplifyHtml(doc.raw.stringByReplacingCharactersInRange(range, withString: ""))
            article.title = self._cleanHtml(title.raw)
        } else {
            article.content = _simplifyHtml(doc.raw)
        }
        return true
    }
    
    func _cleanHtml(text: String) -> String {
        var r: Range<String.Index>
        var s = text
        while true {
            r = s.rangeOfString("<[^>]+>", options: NSStringCompareOptions.RegularExpressionSearch, range: nil, locale: nil)
            if r.isEmpty {
                break
            }
            s = s.stringByReplacingCharactersInRange(r, withString:"")
        }
        return s
    }
    
    func _cleanHtmlFull(text: String) -> String {
        var r: Range<String.Index>
        var s = self._cleanHtml(text)
        while true {
            r = s.rangeOfString("\\s+", options: NSStringCompareOptions.RegularExpressionSearch, range: nil, locale: nil)
            if r.isEmpty {
                break
            }
            s = s.stringByReplacingCharactersInRange(r, withString:"")
        }
        return s
    }
    
    func _simplifyHtml(html: String) -> String {
        // Multistring matches not work
        var r = html.rangeOfString("/<script[^>]*>.*</script>/ig", options: NSStringCompareOptions.RegularExpressionSearch, range: nil, locale: nil)
        if r.isEmpty {
            return html
        }
        return html.stringByReplacingCharactersInRange(r, withString:"")
    }
    
    func _pathFor(elem: TFHppleElement) -> String {
        var el = elem
        var path: String = _complexNameFor(el)
        while nil != el.parent {
            el = el.parent
            path = _complexNameFor(el) + ">" + path
        }
        return path + "!" + String(elem.raw.utf16count)
    }
    
    func _complexNameFor(elem: TFHppleElement) -> String {
        var el = elem
        var name: String = el.tagName

        if let cls : AnyObject = el.attributes["class"] {
            name += "." + (cls as String)
        }
        
        return name
    }
    
    func _baseLevelFor(elem: TFHppleElement) -> TFHppleElement {
        var el = elem.parent
        var simbolCount = self._cleanHtmlFull(el.raw).utf16count
        while true {
            var nSimbolCount = self._cleanHtmlFull(el.parent.raw).utf16count
            if nil != el.parent && (1 == el.parent.children.count/* || simbolCount == nSimbolCount*/) {
                el = el.parent
                simbolCount = nSimbolCount
            } else {
                break
            }
        }
        return el
    }
    
    func _prepareArticleBlocks(blocks: Array<TextBlockCost>) -> Array<TextBlockCost> {
        if blocks.count < 2 {
            return blocks
        }
        
        var preparedBlocks = Array<TextBlockCost>()

        var lastIndex: Int = 0
        for var i = 0 ; i<blocks.count ; i++ {
            let b = blocks[i]
            var lastBlock = b
            lastIndex = i
            for var j=i+1 ; j<blocks.count ; j++ {
                if b.domElement.parent == blocks[j].domElement.parent {
                    lastBlock = blocks[j]
                    lastIndex = j
                }
            }
            if i != lastIndex {
                // Pack
                var contentSize = self._cleanHtml(b.domElement.parent.raw).utf16count
                var nblock = TextBlockCost(path: self._pathFor(b.domElement.parent), domElement: b.domElement.parent,
                    blockCount: 1, contentSize: contentSize, index: i)
                preparedBlocks.append(nblock)
                i = lastIndex
            } else {
                preparedBlocks.append(b)
            }
        }
        
        return preparedBlocks
    }
    
    func _isEqualBlockPath(path1: String, path2: String) -> Bool {
        var r = path1.rangeOfString("\\.[^\\.]$", options: NSStringCompareOptions.RegularExpressionSearch, range: nil, locale: nil)
        if r.isEmpty {
            return false
        }

        var path = path1.stringByReplacingCharactersInRange(r, withString:"")
        var range = NSRange(location: 0, length: countElements(path))
        var nss: NSString = path
        return nss.substringWithRange(range) == path
    }
}
