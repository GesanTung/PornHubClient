//
//  GTBase.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/15.
//  Copyright © 2019 laofeng. All rights reserved.
//

import Foundation

public struct GTBase<Base> {
    public let base:Base

    public init(base: Base) {
        self.base = base
    }
}

public protocol GTBaseProtocol {
    associatedtype BaseType

    static var gt: GTBase<BaseType>.Type { get }

    var gt: GTBase<BaseType> { get }
}

public extension GTBaseProtocol {
    public static var gt: GTBase<Self>.Type {
        get {
            return GTBase<Self>.self
        }
    }

    public var gt: GTBase<Self> {
        get {
            return GTBase.init(base: self)
        }
    }
}

extension NSObject: GTBaseProtocol { }

