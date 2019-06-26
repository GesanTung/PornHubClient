//
//  HomeTopView.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/18.
//  Copyright © 2019 laofeng. All rights reserved.
//

import UIKit

class HomeTopView: UIView {
    let channelsView = UICollectionView.init(scrollDirection: .horizontal)


    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildView()
    }
}

extension HomeTopView: GTViewBuild {
    func buildViewTree() {
        addSubview(channelsView)
    }

    func buildViewLayout() {
        channelsView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(CMTool.kStatusBarHeight)
            make.left.bottom.equalToSuperview()
            make.height.equalTo(147.pixel)
        }
    }

    func buildViewConfig() {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        channelsView.collectionViewLayout = layout
        channelsView.showsVerticalScrollIndicator = false
        channelsView.showsHorizontalScrollIndicator = false
        channelsView.scrollsToTop = false
        channelsView.contentInset.left = 4
        if #available(iOS 11.0, *) {
            channelsView.contentInsetAdjustmentBehavior = .never
        }
    }
}

