//
//  UIColor.swift
//  FindEmoji
//
//  Created by Simon Støvring on 20/08/2015.
//  Copyright © 2015 SimonBS. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func findEmojiPrimaryColor() -> UIColor {
        return .rgba(r: 254, g: 101, b: 79, a: 1)
    }
    
    static func findEmojiSecondaryColor() -> UIColor {
        return .rgba(r: 81, g: 79, b: 89, a: 1)
    }
    
    static func findEmojiDetailColor() -> UIColor {
        return .rgba(r: 174, g: 209, b: 230, a: 1)
    }
    
    static func findEmojiBackgroundColor() -> UIColor {
        return .rgba(r: 254, g: 254, b: 254, a: 1)
    }
    
    static func findEmojiAlternateBackgroundColor() -> UIColor {
        return .rgba(r: 248, g: 248, b: 248, a: 1)
    }
    
    static func findEmojiDiscreetColor() -> UIColor {
        return .rgba(r: 176, g: 176, b: 176, a: 1)
    }
    
    static func rgba(r r: Int, g: Int, b: Int, a: Float) -> UIColor {
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a))
    }
    
}