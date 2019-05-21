//
//  NetworkLoggger.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/21.
//  Copyright © 2019 laofeng. All rights reserved.
//

import Foundation
import Moya
import Result

class NetworkLogger: PluginType {

    /// Called immediately before a request is sent over the network (or stubbed).
    func willSend(_ request: RequestType, target: TargetType) {
        if logNetwork {
            debugPrint("CollectorAPI Sending : \(request.request?.url?.absoluteString ?? String())")
        }
    }
    /// Called after a response has been received, but before the MoyaProvider has invoked its completion handler.
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        if logNetwork {
            switch result {
            case .success(let response):
                debugPrint("CollectorAPI Recieve from: \(response.response?.url?.absoluteString ?? String())")
                if let json = try? response.mapString() {
                    debugPrint("Response: \(json)")
                }
            case .failure(let error):
                debugPrint("CollectorAPI Recieve error: \(error)")
            }
        }
    }

}

