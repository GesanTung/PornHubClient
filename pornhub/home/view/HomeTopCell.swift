//
//  HomeTopCell.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/20.
//  Copyright © 2019 laofeng. All rights reserved.
//

import UIKit

class HomeTopCell: UICollectionViewCell {
    let titleLabel: UILabel

    override init(frame: CGRect) {
        titleLabel = UILabel.init(frame: frame)
        super.init(frame: frame)
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension HomeTopCell: GTViewBuild {
    func buildViewTree() {
        [titleLabel].forEach { (v) in
            contentView.addSubview(v)
        }
    }

    func buildViewLayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }

    func buildViewConfig() {
        titleLabel.font = UIFont.systemFont(ofSize: GTFontSize.l.fontSize)
        titleLabel.textAlignment = .center
        contentView.backgroundColor = nil
        backgroundColor = nil
    }
}
