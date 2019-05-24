//
//  NetWorkServerErrorFilter.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/21.
//  Copyright © 2019 laofeng. All rights reserved.
//

import Foundation
import Moya
import Result
import RxSwift

class NetWorkServerErrorFilter: PluginType {

    static let share = NetWorkServerErrorFilter()

    lazy var statusCode: Observable<(Int, TargetType)> = {
        return _statusCode.asObserver()
    }()

    private init() {
    }

    private var _statusCode: PublishSubject<(Int, TargetType)> = PublishSubject()
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            if let object = try? JSONDecoder().decode(NetModel.self, from: response.data) {
                _statusCode.onNext((object.status, target))
            }
        default:
            return
        }
    }
}

