//
//  Extensions.swift
//  Flowchart
//
//  Created by Todd Olsen on 5/10/16.
//  Copyright © 2016 Todd Olsen. All rights reserved.
//

import UIKit

extension UIColor {

    @nonobjc static let Mercury: UIColor   = UIColor(rgb: 0xE6E6E6)
    @nonobjc static let Highlight: UIColor = UIColor(rgb: 0xFABF1A)
    @nonobjc static let Steel: UIColor     = UIColor(rgb: 0x666666)
    @nonobjc static let Orange: UIColor    = UIColor(rgb: 0xFABF1A)

    convenience init(rgb: UInt32) {
        self.init(
            red:    CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green:  CGFloat((rgb & 0x00FF00) >>  8) / 255.0,
            blue:   CGFloat((rgb & 0x0000FF) >>  0) / 255.0,
            alpha:  1.0
        )
    }
}


extension UIView {

    var cornerRadius: Double {
        get {
            return Double(layer.cornerRadius)
        }
        set {
            layer.cornerRadius = CGFloat(newValue)
        }
    }

    var borderColor: UIColor? {
        get {
            return layer.borderColor != nil ? UIColor(CGColor: layer.borderColor!) : nil
        }
        set {
            if newValue != nil {
                layer.borderColor = newValue!.CGColor
            }
        }
    }

    var borderWidth: Double {
        get {
            return Double(layer.borderWidth)
        }
        set {
            layer.borderWidth = CGFloat(newValue)
        }
    }
    
    
}
