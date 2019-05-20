//
//  GTDevice.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/18.
//  Copyright © 2019 laofeng. All rights reserved.
//

import UIKit
import Device

struct CMTool {
    static let kscale = UIScreen.main.scale
    static let (kScreenWidth, kScreenHeight) = (min(UIScreen.main.bounds.width, UIScreen.main.bounds.height), max(UIScreen.main.bounds.width, UIScreen.main.bounds.height))

    static var kStatusBarHeight: CGFloat {
        switch Device.size() {
        case .screen5_8Inch, .screen6_1Inch, .screen6_5Inch:
            return 44
        default:
            return 20
        }
    }

    static let isLessEqualIphone5s: Bool = {
        if CMTool.kScreenWidth <= 321 { return true}
        return false
    }()

    static let isIPhoneX: Bool = {
        return Device.size() == .screen5_8Inch
    }()

    static let isIPhoneXSeries: Bool = {
        switch Device.size() {
        case .screen5_8Inch, .screen6_1Inch, .screen6_5Inch:
            return true
        default:
            return false
        }
    }()

    static let isBeforeiPhone6: Bool = {
        if Device.size() < .screen4_7Inch {
            return true
        }
        return false
    }()

    static let isEqualOrBeforeiPhone6: Bool = {
        if Device.size() < .screen4_7Inch {
            return true
        } else if Device.version() == .iPhone6 {
            return true
        } else if Device.version() == .iPhone6Plus {
            return true
        }
        return false
    }()

}

