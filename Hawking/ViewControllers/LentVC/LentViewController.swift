//
//  LentViewController.swift
//  Hawking
//
//  Created by Alex Zimin on 28/06/14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import UIKit
//import Grabber

class LentViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate {

    @IBOutlet var tableView: UITableView?
    var isFave = false;
    var dataList: Array<AnyObject>?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let identifier: String? = "LentFeedCell";
        self.tableView!.registerNib(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier);
      
        title = (isFave) ? "Fave" : "Lent"
        
//        navigationController.condensesBarsOnSwipe = true
        // Do any additional setup after loading the view.
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//            Grabber().grabList(url: "http://habr.ru", success: { list in
//                    self.dataList = list
//                    dispatch_async(dispatch_get_main_queue(), {
//                        self.tableView.reloadData()
//                    });
//                    return
//                }, failure: {error in
//                    println(error)
//                })
//        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UITableViewDataSource
    //////////////////////////////////////////////////////////////////////////////////////
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return nil != dataList ? dataList!.count : 0
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 128
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let identifier: String? = "LentFeedCell";
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as LentFeedCell
        
        if let data = self.dataList![indexPath.item] as? NSDictionary {
            var title: String = ""
            var desc: String = ""
            
            if let t = data["title"] as? String {
                title = t
            }
            if let d = data["description"] as? String {
                desc = d
            }
            
            cell.fillContent(nil, title: title, text: desc)
        } else {
            cell.fillContent(nil, title: "Title", text: "Some info, Some info")
        }
        
//        if indexPath.row == 0 {
//            cell.fillContent(UIImage(named: "breakingnews1.jpg"), title: "Title", text:  "визуализация — это больше, чем просто инструмент для поиска закономерностей среди данных, — пишет Майк Босток. — Визуализация использует зрительную систему человека, чтобы расширить человеческий интеллект: с её помощью мы лучше понимаем важные абстрактные процессы oабота уникальная, в своём роде, потому что в этом случае графическое отображение особенно сложно сделать: ведь, по сути, нет данных для анализа. «Но алгоритмы также демонстрируют, что визуализация — это больше, чем просто")
//        } else {
//            cell.fillContent(nil, title: "Title", text: "Some info, Some info")
//        }
        
        cell.leftUtilityButtons = rightButtons()
        cell.delegate = self
        
        return cell
    }
    
    //////////////////////////////////////////////////////////////////////////////////////
    // MARK: - UITalbeViewDelegat
    //////////////////////////////////////////////////////////////////////////////////////
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        if let data = self.dataList![indexPath.item] as? NSDictionary {
            if let link = data["link"] as? String {
                var article = ArticleViewController(nibName: "ArticleViewController", bundle: nil)
                article.url = link
                navigationController.pushViewController(article, animated: true);
            }
        }
    }
    
    //////////////////////////////////////////////////////////////////////////////////////
    // MARK: - SWTableViewCellButtons
    //////////////////////////////////////////////////////////////////////////////////////
    
    func rightButtons() -> NSMutableArray {
        var array: NSMutableArray = NSMutableArray()
        array.sw_addUtilityButtonWithColor(UIColor.redColor(), title: "Delete");
        array.sw_addUtilityButtonWithColor(UIColor.mainColor(), title: "Fave");
        
        return array
    }
    
    //////////////////////////////////////////////////////////////////////////////////////
    // MARK: - SWTableViewCellDelegats
    //////////////////////////////////////////////////////////////////////////////////////
    
    func swipeableTableViewCell(cell: SWTableViewCell, didTriggerLeftUtilityButtonWithIndex index: Int)
    {
        println(index)
    }

}
