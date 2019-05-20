//
//  GTViewBuild.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/18.
//  Copyright © 2019 laofeng. All rights reserved.
//

import Foundation

public protocol GTViewBuild {

    func buildView()

    func buildProperty()

    func buildViewTree()

    func buildViewLayout()

    func buildViewConfig()
}

public extension GTViewBuild {
    func buildProperty() {}
    func buildViewTree() {}
    func buildViewLayout() {}
    func buildViewConfig() {}

    func buildView() {
        buildProperty()
        buildViewTree()
        buildViewLayout()
        buildViewConfig()
    }
}

public protocol GTViewData {
    associatedtype ViewDataType

    func showData(data:ViewDataType)
}
