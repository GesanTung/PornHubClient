//
//  Homeservice.swift
//  pornhub
//
//  Created by Gesantung on 2019/5/27.
//  Copyright © 2019 laofeng. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeService {
    func getCategory() -> Observable<HomeVideoCategoryRes>
    func getVideoList(cid: Int) -> Observable<Void>
}

class HomeServiceImpl: HomeService {
    func getCategory() -> Observable<HomeVideoCategoryRes> {
        return netWork.request(.homeGetCategory)
            .mapToModel(HomeVideoCategoryRes.self)
            .share()
    }
    func getVideoList(cid: Int) -> Observable<Void> {
        return netWork.request(.homeGetCategory)
            .mapVoid()
            .share()
    }
}
