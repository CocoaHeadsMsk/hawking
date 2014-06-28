//
//  UIimageExtensions.swift
//  Hawking
//
//  Created by Alex Zimin on 28/06/14.
//  Copyright (c) 2014 CocoaHeadsMsk. All rights reserved.
//

import UIKit

extension UIImage {
    func imageWithOverlayColor(color: UIColor) -> UIImage {
        
        var rect = CGRectMake(0.0, 0.0, self.size.width, self.size.height)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 2.0)
        
        self.drawInRect(rect)
        
        var context = UIGraphicsGetCurrentContext()
        CGContextSetBlendMode(context, kCGBlendModeSourceIn)
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect);
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image;
    }
}