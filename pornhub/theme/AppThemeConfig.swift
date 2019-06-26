//
//  AppThemeConfig.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/15.
//  Copyright © 2019 laofeng. All rights reserved.
//

import UIKit

public enum GTFontSize : Int {
    case xxxl = 70 //用于新闻详情标题
    case xxl = 60
    case xl = 54
    case xl_reduce = 51
    case l = 48
    case l_reduce = 42
    case m = 40
    case s = 33
    case xs = 30

    public var fontSize: CGFloat {
        return rawValue.pixel
    }
}


public enum GTCommonColor {
    case theme
    case blue
    case yellow
    case red
}

public struct GTThemeSettings {

    public static func commonColor(_ color: GTCommonColor, alpha: Double = 1.0) -> UIColor {
        var realColor: UIColor
        switch (color) {
        case .theme:
            realColor = UIColor.gt.colorWith(hex: 0xf7971d, alpha: alpha)
        case .blue:
            realColor = UIColor.gt.colorWith(hex: 0x5a89fa, alpha: alpha)
        case .yellow:
            realColor = UIColor.gt.colorWith(hex: 0xf78826, alpha: alpha)
        case .red:
            realColor = UIColor.gt.colorWith(hex: 0xff0000, alpha: alpha)
        }
        return realColor
    }

    public static func commonFont(_ font: GTFontSize) -> UIFont {
        var font: UIFont
        font = UIFont.systemFont(ofSize: 48.pixel)
        return font
    }
}
