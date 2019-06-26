//
//  UIColorExt.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/15.
//  Copyright © 2019 laofeng. All rights reserved.
//

import UIKit

public extension GTBase where Base : UIColor {

    public static func colorWith(hex: Int, alpha: Double = 1) -> UIColor {
        return colorWithHex(r: (hex >> 16) & 0xFF, g: (hex >> 8) & 0xFF, b: hex & 0xFF, a: CGFloat(alpha))
    }
    /// color
    ///
    /// - Parameters:
    ///   - r: read [0, 255]
    ///   - g: green [0, 255]
    ///   - b: blue [0, 255]
    ///   - a: alpha vallue [0, 1]
    /// - Returns: color
    public static func colorWithHex(r:Int, g: Int, b: Int, a: CGFloat = 1) -> UIColor {
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: a)
    }
}
