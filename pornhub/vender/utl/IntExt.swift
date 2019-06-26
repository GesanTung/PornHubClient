//
//  IntExt.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/15.
//  Copyright © 2019 laofeng. All rights reserved.
//

import UIKit

public extension Int {
    /// convert to pixel: 5.7inch as criterion
    public var pixel: CGFloat {
        let mod = CGFloat(self % 3) / CMTool.kscale
        return CGFloat(self / 3) + mod
    }

}
