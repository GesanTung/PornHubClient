//
//  NetworkAPI.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/21.
//  Copyright © 2019 laofeng. All rights reserved.
//

import Foundation
import Moya

let netWork = NetworkProvider<CollectorAPI>()

enum CollectorAPI: TargetType, CollectorAPIType {

    case login(account: String, password: String, vcode: String)

}

protocol CollectorAPIType {
    var base: String { get }
    var parameters: [String: Any] { get }
}

extension CollectorAPIType {

    func buildParams(_ parameters: [String: Any]? = nil) -> ([String: Any]) {
        func paramsJsonString() -> String? {
            if let d = parameters, let data = try? JSONSerialization.data(withJSONObject: d, options: JSONSerialization.WritingOptions.init(rawValue: 0)) {
                return String.init(data: data, encoding: String.Encoding.utf8)
            }
            return nil
        }

        let client = APIContext.client

        let timestamp = Int64(Date.init().timeIntervalSince1970 * 1000)

        let data = paramsJsonString() ?? ""
        let requestId = UUID.init().uuidString

        let realParams = [
            "timestamp": String(timestamp),

            "data": data,
            "client": client,
            "account": requestId
        ]
        return realParams
    }

    var base: String {
        return globalAPIEnvironment.rawValue
    }
}

extension CollectorAPI {
    var parameters: [String: Any] {
        var _parameter: [String: Any]? = [:]
        switch self {
        case .login(let account,  let password,  let vcode ):
            _parameter?["account"] = account
            _parameter?["password"] = password
            _parameter?["vcode"] = vcode
        }
        return buildParams(_parameter)
    }

    var path: String {
        switch self {
        case .login:
            return "login"

        }
    }

    var method: Moya.Method {
        return .post
    }

    var sampleData: Data {
        return stubResponse(self.path)
    }

    var task: Task {
        return Task.requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }

    var baseURL: URL {
        return URL.init(string: base)!
    }

    var headers: [String : String]? {
        return nil
    }
}

func stubResponse(_ filename: String) -> Data {
    let bundle = Bundle.main
    if let path = bundle.path(forResource: filename, ofType: "json") {
        return (try? Data(contentsOf: URL(fileURLWithPath: path))) ?? Data.init()
    }
    return Data.init()
}


