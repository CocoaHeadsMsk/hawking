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
    
    init(Title title:String, atricleText text:String, imagePaths:Array<NSURL>){
        self.Title = title
        self.Text = text
        self.ImagePath = imagePaths
    }
}
