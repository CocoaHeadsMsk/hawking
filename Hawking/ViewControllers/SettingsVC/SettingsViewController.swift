//
//  SettingsViewController.swift
//  Hawking
//
//  Created by Alex Zimin on 28/06/14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import UIKit

enum SettingSections : Int
{
    case ArticleControll, AboutProgramm
}

enum ArticleControllCells : Int
{
    case ArticleControllAdd, ArticleControllSugestions
}

enum AboutProgrammCells : Int
{
    case AboutProgrammInfo, AboutProgrammMailUs, AboutProgrammVersion
}

class SettingsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    var sections = [SettingSections.ArticleControll, SettingSections.AboutProgramm]
    var articleControllCells = [ArticleControllCells.ArticleControllAdd, ArticleControllCells.ArticleControllSugestions]
    var aboutProgrammCells = [AboutProgrammCells.AboutProgrammInfo, AboutProgrammCells.AboutProgrammMailUs, AboutProgrammCells.AboutProgrammVersion]
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return sections.count
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        var sectionType: SettingSections = sections[section]
        
        switch (sectionType) {
        case .ArticleControll:
            return articleControllCells.count
        case .AboutProgramm:
            return aboutProgrammCells.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        return UITableViewCell()
    }

}
