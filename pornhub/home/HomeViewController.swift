//
//  HomeViewController.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/15.
//  Copyright © 2019 laofeng. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    lazy var headerView = HomeTopView.init()

    lazy var contentView = UICollectionView.init(scrollDirection: .horizontal)

    private let viewModel = HomeVideoViewModel.init(service: HomeServiceImpl())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildView()
        viewModel.fetchCategoryInfo()
    }

}

extension HomeViewController: GTViewBuild {
    func buildViewTree() {
        [contentView, headerView].forEach { (v) in
            view.addSubview(v)
        }

    }

    func buildViewLayout() {
        headerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }

        contentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    func buildViewConfig() {
        headerView.channelsView.register(HomeTopCell.self, forCellWithReuseIdentifier: HomeTopCell.className)
        contentView.register(HomePageViewCell.self, forCellWithReuseIdentifier: HomePageViewCell.className)
        contentView.showsVerticalScrollIndicator = false
        contentView.showsHorizontalScrollIndicator = false
        contentView.isPagingEnabled = true

        // navigationBar 隐藏
        self.view.backgroundColor = UIColor.gt.colorWith(hex: 0x111111)
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.isNavigationBarHidden = true
        if #available(iOS 11.0, *) {
            contentView.contentInsetAdjustmentBehavior = .never
        }

    }
}
