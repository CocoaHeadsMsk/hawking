//
//  LentViewController.swift
//  Hawking
//
//  Created by Alex Zimin on 28/06/14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import UIKit

class LentViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView
    var isFave = false;
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let identifier: String? = "LentFeedCell";
        self.tableView.registerNib(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier);
        
        title = (isFave) ? "Fave" : "Lent"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
       return 2
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 128
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let identifier: String? = "LentFeedCell";
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as LentFeedCell
        
        if indexPath.row == 0 {
            cell.fillContent(UIImage(named: "breakingnews1.jpg"), title: "Title", text:  "визуализация — это больше, чем просто инструмент для поиска закономерностей среди данных, — пишет Майк Босток. — Визуализация использует зрительную систему человека, чтобы расширить человеческий интеллект: с её помощью мы лучше понимаем важные абстрактные процессы oабота уникальная, в своём роде, потому что в этом случае графическое отображение особенно сложно сделать: ведь, по сути, нет данных для анализа. «Но алгоритмы также демонстрируют, что визуализация — это больше, чем просто")
        } else {
            cell.fillContent(nil, title: "Title", text: "Some info, Some info")
        }
        
        
        return cell
    }

}
