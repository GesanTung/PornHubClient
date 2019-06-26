//
//  GTTabbarController.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/11.
//  Copyright © 2019 laofeng. All rights reserved.
//

import UIKit
import SnapKit

//Tab按钮
protocol CMTabBarDelegate: NSObjectProtocol {
    func tabBarDidClick(from: TabControllerType, to: TabControllerType)
}

protocol CMTabBarClickDelegate: NSObjectProtocol {
    func tabBarDidSelected()
}

class CMTabbarController: UITabBarController, CMTabBarDelegate, CAAnimationDelegate {

    fileprivate var tabs: [AnyObject] = []

    var customTabBar = CMTabBar()  // 自定义tabBar

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for child: UIView in tabBar.subviews {
            if child.isKind(of: UIImageView.self) || child.isKind(of: UIControl.self) {
                child.isHidden = true
            }
        }
    }

    func config(tabs: [TabControllerType]) {
        for tab in tabs {
            let controller = tab.controller
            let mainNavVC = RootNavigationController.init(navigationBarClass: UINavigationBar.self, toolbarClass: nil)
            mainNavVC.addChild(controller)
            addChild(mainNavVC)
        }

        customTabBar.addTabBar(types: tabs)
        customTabBar.delegate = self
        tabBar.addSubview(customTabBar)
        customTabBar.snp.makeConstraints { (make) in
            make.edges.equalTo(tabBar)
        }

        tabBar.backgroundImage = UIImage()
    }

    func tabBarDidClick(from: TabControllerType, to: TabControllerType) {
        selectedIndex = self.customTabBar.items.index(where: { $0.barItemType == to }) ?? 0

    }
}
