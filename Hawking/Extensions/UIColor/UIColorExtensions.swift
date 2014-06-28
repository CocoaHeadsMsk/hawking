//
//  UIColorExtensions.swift
//  Hawking
//
//  Created by Alex Zimin on 28/06/14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        var rString = cString.substringFromIndex(0).substringToIndex(2)
        var gString = cString.substringFromIndex(2).substringToIndex(4)
        var bString = cString.substringFromIndex(4).substringToIndex(6)
        
        var n:CUnsignedInt = 0
        NSScanner.scannerWithString(cString).scanHexInt(&n)
        return UIColorFromRGB(UInt(n))
    }
    
    class func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func mainColor() -> UIColor {
        return UIColor.colorWithHexString("3399cc")
    }
}