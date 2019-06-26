//
//  AppRootNode.swift
//  pronhub
//
//  Created by Gesantung on 2019/4/29.
//  Copyright © 2019 laofeng. All rights reserved.
//

import UIKit

open class RootNavigationController: UINavigationController {

    override open var shouldAutorotate : Bool {
        return topViewController?.shouldAutorotate ?? false
    }

    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? .portrait
    }
}

struct AppRootNode {
    // app 的主要 window
    static let appMainWindow = UIWindow.init()

    /// app 主要流程(window)的 nav
    static let appMainRootNav: RootNavigationController = {
        let vc = RootNavigationController()
        vc.isNavigationBarHidden = true
        return vc
    }()

    static func createAppFrame() {
        let tab = CMTabbarController()
        tab.config(tabs: [.home, .found,.mine])
        appMainWindow.rootViewController = tab
    }

    /// 当前 app 的 root nav
    static var currentRootNav: UINavigationController? {
        return UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
    }
}

extension AppRootNode {


}

