//
//  HomeModel.swift
//  pornhub
//
//  Created by Gesantung on 2019/5/27.
//  Copyright © 2019 laofeng. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeVideoCategoryModel: Codable {
    var name: String?
    var cid: Int?
}

class HomeVideoModel {
    var videoUrl: String?
    var VideoTitle: String?
}

struct HomeVideoCategoryRes: Codable {
    var list: [HomeVideoCategoryModel]
}

class HomeVideoViewModel {

    let service: HomeService

    init(service: HomeService) {
        self.service = service
    }

    func fetchCategoryInfo() {
        service.getCategory()
            .subscribe(onNext: { [weak self] (category) in
                let pcategory = category
                print(pcategory)
            })
    }
}
