//
//  IntExt.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/15.
//  Copyright © 2019 laofeng. All rights reserved.
//

import UIKit

public let kscale = UIScreen.main.scale
public let (kscreenWidth, kscreenHeight) = (min(UIScreen.main.bounds.width, UIScreen.main.bounds.height), max(UIScreen.main.bounds.width, UIScreen.main.bounds.height))

public extension Int {
    /// convert to pixel: 5.7inch as criterion
    public var pixel: CGFloat {
        let mod = CGFloat(self % 3) / kscale
        return CGFloat(self / 3) + mod
    }

}
