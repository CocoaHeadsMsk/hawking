//
//  StringExtensions.swift
//  Hawking
//
//  Created by Alex Zimin on 28/06/14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import Foundation

extension String
{
    var length: Int {
        return self.bridgeToObjectiveC().length
    }
}
