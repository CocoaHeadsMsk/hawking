//
//  Article.swift
//  Hawking
//
//  Created by Morozov Maksim on 28.06.14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import UIKit

class Article {
    let Title:String
    let Text:String
    let ImagePath : Array<NSURL>
    let Id : Int
    let URL: NSURL
    var _Price: Int
    
    init(Title title:String, atricleText text:String, imagePaths:Array<NSURL>, id:Int , price:Int, url: NSURL){
        self.Title = title
        self.Text = text
        self.ImagePath = imagePaths
        self.Id = id
        self._Price = price
        self.URL=url
    }
    
    func incrementArticlePrice(){
        _Price++;
    }
    
    func decrementArticlePrice(){
        _Price--;
    }
}
