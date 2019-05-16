//
//  GTTabbarItem.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/11.
//  Copyright © 2019 laofeng. All rights reserved.
//

import UIKit
import SnapKit

class CMTabBarItem: UIButton {

    fileprivate let badgeView = UIImageView.init(image: nil)

    private(set) var barItemType: TabControllerType {
        didSet {
            itemData = barItemType.data
        }
    }
    /// data
    private var itemData: CMTabBarItemData {
        didSet {
            configWith(item: itemData)
        }
    }

    override init(frame: CGRect) {
        barItemType = .home
        itemData = barItemType.data
        super.init(frame: frame)
        titleLabel?.textAlignment = NSTextAlignment.center
        imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        self.addSubview(badgeView)
        badgeView.snp.remakeConstraints { (make) in
            make.width.height.equalTo(15)
            make.centerY.equalTo(self).offset(-12)
            make.centerX.equalTo(self).offset(18)
        }
        badgeView.isHidden = true
        titleLabel?.font = UIFont.systemFont(ofSize: GTTabbarConfig.titlesize)
        setTitleColor(GTTabbarConfig.titleNormalColor, for: .normal)
        setTitleColor(GTTabbarConfig.titleSelectColor, for: .selected)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleY = floor(bounds.height * 0.6)
        let titleW = contentRect.size.width
        let titleH = bounds.height - titleY
        let titleX: CGFloat = 0.0
        return CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
    }

    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let csize = self.bounds.size
        let size = CGSize.init(width: 25, height: 25)
        return CGRect.init(origin: .init(x: (csize.width - size.width) / 2, y: 5), size: size)
    }

}

extension CMTabBarItem {
    private func configWith(item: CMTabBarItemData) {
        setTitle(item.title, for: UIControl.State())
        setImage(item.dayImage, for: .normal)
        setImage(item.seletedImage, for: .selected)
    }

    func configWith(type: TabControllerType) {
        barItemType = type
    }

    func showBadge(show: Bool) {
        badgeView.isHidden = !show
        if show {
            let animation = CAKeyframeAnimation.init(keyPath: "position.x")
            animation.values = [56, 61, 56, 59, 56, 56]
            animation.keyTimes = [0.0, 0.2 / 1.68, 0.38 / 1.68, 0.54 / 1.68, 0.68 / 1.68, 1.0] as [NSNumber]
            animation.duration = CFTimeInterval.init(1.68)
            animation.repeatCount = Float.greatestFiniteMagnitude
            badgeView.layer.add(animation, forKey: "badge")
        } else {
            badgeView.layer.removeAnimation(forKey: "badge")
        }
    }

    func setItem(selected: Bool) {
        defer {
            isSelected = selected
        }


        guard selected, isSelected != selected else {
            return
        }
        //setImage(UIImage(), for: .selected)

    }

}

enum TabControllerType {
    case home
    case found
    case mine
}

extension TabControllerType {
    var data: CMTabBarItemData {
        switch self {
        case .home:
            return .init(title:"首页", dayImage: #imageLiteral(resourceName: "tab_home_n_icon"), nightImage: #imageLiteral(resourceName: "tab_home_s_icon"), seletedImage: #imageLiteral(resourceName: "tab_home_s_icon"))
        case .found:
            return .init(title:"发现", dayImage: #imageLiteral(resourceName: "tab_found_n_icon"), nightImage: #imageLiteral(resourceName: "tab_found_s_icon"), seletedImage: #imageLiteral(resourceName: "tab_found_s_icon"))
        case .mine:
            return .init(title:"我的", dayImage: #imageLiteral(resourceName: "tab_mine_n_icon"), nightImage: #imageLiteral(resourceName: "tab_mine_s_icon"), seletedImage: #imageLiteral(resourceName: "tab_mine_s_icon"))
        }
    }

    var controller: UIViewController {
        switch self {
        case .home:
            return HomeViewController.init()
        case .found:
            return HomeViewController.init()
        case .mine:
            return MineViewController.init()
        }
    }

}

struct CMTabBarItemData {
    var badge: String?
    var title: String?

    // 图片
    var dayImage: UIImage?
    var nightImage: UIImage?
    var seletedImage: UIImage?

    init() {
        self.title = nil
        self.dayImage = nil
        self.nightImage = nil
        self.seletedImage = nil
        self.badge = nil
    }

    init(title: String?, dayImage: UIImage?, nightImage: UIImage?, seletedImage: UIImage?) {
        self.title = title
        self.dayImage = dayImage
        self.nightImage = nightImage
        self.seletedImage = seletedImage
        self.badge = nil
    }
}

