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
    
    init(Name name: String, sourceUrl:NSURL){
        self.Name = name
        self.Url = sourceUrl
    }
    
}
