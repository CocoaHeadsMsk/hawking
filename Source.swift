//
//  NewsSource.swift
//  Hawking
//
//  Created by Morozov Maksim on 28.06.14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//
import UIKit

class Source {
    let Url:NSURL
    let Name: String
    let Id:Int
    
    init(Name name: String, sourceUrl:NSURL , id:Int){
        self.Name = name
        self.Url = sourceUrl
        self.Id = id
    }
    
}
