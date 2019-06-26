//
//  NSObjectExt.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/20.
//  Copyright © 2019 laofeng. All rights reserved.
//

import Foundation

public extension NSObject {
    public class var fullClassName: String {
        return String.init(reflecting: self)
    }

    public class var className : String {
        return String.init(describing: self)
    }
}
