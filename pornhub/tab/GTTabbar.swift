//
//  GTTabbar.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/11.
//  Copyright © 2019 laofeng. All rights reserved.
//

import UIKit
import SnapKit

class CMTabBar: UIView {
    var items: [CMTabBarItem] = []
    var selectedTabBarItem: CMTabBarItem?
    let tabBarHeight = CGFloat(49.0)

    let circle = UIView()
    weak var delegate: CMTabBarDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = GTTabbarConfig.backgroundColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if !items.isEmpty {
            let buttonW = frame.size.width/CGFloat(items.count)
            var index = 0
            for item in items {
                let buttonX = buttonW * CGFloat(index)
                item.frame = CGRect(x: buttonX, y: 0.0, width: buttonW, height: tabBarHeight)
                index += 1
            }
        }
    }

    func addCircleInCenterItem() {
        // shadowCode
        circle.layer.shadowColor = UIColor(red: 0.47, green: 0.5, blue: 0.57, alpha: 0.3).cgColor
        circle.layer.shadowOffset = CGSize(width: 0, height: 1)
        circle.layer.shadowOpacity = 0.3
        circle.layer.shadowRadius = 9.7
        // frameFxCode
        let borderLayer = CALayer()
        borderLayer.frame = circle.bounds
        borderLayer.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.68).cgColor
        borderLayer.cornerRadius = 63.0 / 2
        circle.layer.addSublayer(borderLayer)
        // layerFillCode
        let layer = CALayer()
        layer.frame = CGRect(x: 1, y: 1, width: 61, height: 61)
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 61.0 / 2
        circle.layer.addSublayer(layer)
        addSubview(circle)
    }

    func layoutCircle() {
        circle.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(63)
            make.top.equalToSuperview().offset(-12)
        }
        insertSubview(items[2], aboveSubview: circle)
    }

    @objc func tabBarItemDidClick(_ tabBarItem: CMTabBarItem) {
        let from = selectedTabBarItem?.barItemType ?? .home
        let to = tabBarItem.barItemType
        items.forEach { (item) in
            if item != tabBarItem {
                item.setItem(selected: false)
            }
        }

        tabBarItem.setItem(selected: true)
        selectedTabBarItem = tabBarItem

        delegate?.tabBarDidClick(from: from, to: to)
    }

}

extension CMTabBar {
    func addTabBar(types: [TabControllerType]) {
        for (index, type) in types.enumerated() {
            let tabBarItem = CMTabBarItem()
            tabBarItem.configWith(type: type)
            tabBarItem.addTarget(self, action: #selector(self.tabBarItemDidClick(_:)),
                                 for: UIControl.Event.touchUpInside)
            addSubview(tabBarItem)
            items.append(tabBarItem)
            if index ==  0 {
                tabBarItem.isSelected = true
                selectedTabBarItem = tabBarItem
            }
        }
    }

    func displayBadge(types: [TabControllerType], show: Bool) {
        let set = Set.init(types)
        self.items.filter({ set.contains($0.barItemType) }).forEach { (item) in
            item.showBadge(show: show)
        }
    }

}

