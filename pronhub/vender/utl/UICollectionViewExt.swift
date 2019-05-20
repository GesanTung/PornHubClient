//
//  UICollectionViewExt.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/18.
//  Copyright © 2019 laofeng. All rights reserved.
//

import UIKit

extension UICollectionView {
    convenience init(scrollDirection: UICollectionView.ScrollDirection, itemSize: CGSize = UIScreen.main.bounds.size) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = itemSize
        self.init(frame: UIScreen.main.bounds, collectionViewLayout: layout)
    }
}

