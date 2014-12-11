//
//  ArticleViewController.swift
//  Hawking
//
//  Created by Alex Zimin on 29/06/14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import UIKit
//import Grabber

class ArticleViewController: BaseViewController {

    @IBOutlet var webView: UIWebView
    
    var url: String?
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        if nil != url {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                Grabber().grabArticle(url: self.url!, success: { article in
//                    dispatch_async(dispatch_get_main_queue(), {
//                        self.webView.loadHTMLString(article.content, baseURL: nil)
//                        });
//                    }, failure: {error in
//                        println(error)
//                    })
//                })
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func hidesBottomBarWhenPushed() -> Bool
    {
        return true
    }
    
    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
