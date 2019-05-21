//
//  APIContext.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/21.
//  Copyright © 2019 laofeng. All rights reserved.
//

import Foundation

let stubWhiteList = [
    "getArticleList",
    "getAllInfo",
    "getClueIndex",
    "getMyAcceptClueList",
    "getSelectedClueList",
    "delSelectedClue",
    "getClueDetail",
    "getArticleDetail",
    "getNotificationList"
]

enum APIEnvironment: String {
    case develop = "http://170.240.110.120/"
    case test = "http://47.97.243.140:8036/"
    case innerTest = "http://170.240.110.218:80"
    case pubTest = "http://120.26.104.64:8081/"
    case product = "https://imapi.thecover.cn/"
}

struct APIContext {
    static let version =  Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    static let client = "iOS"
}

enum CollectorError {
    case timeOut
    case offline
    case server(Int, String)
    case badData
    case custom(String)
}

extension CollectorError: Error {}

extension CollectorError {
    var errorMessage: String {
        switch self {
        case .timeOut:
            return "网络超时，请重新尝试"
        case .offline:
            return "网络连接失败，请重新尝试"
        case .server(_, let msg):
            return msg
        case .badData:
            return "服务器返回数据异常"
        case .custom(let msg):
            return msg
        }
    }

    var code: Int {
        var _code: Int
        switch self {
        case .timeOut, .offline, .badData, .custom:
            _code = -1
        case .server(let code, _):
            _code = code
        }
        return _code
    }

}

func == (l: CollectorError, r: CollectorError) -> Bool {
    switch(l, r) {
    case (.timeOut, .timeOut), (.offline, .offline), (.badData, .badData):
        return true
    case (.custom(let m1), .custom(let m2)) where m1 == m2:
        return true
    case (.server(let c1), .server(let c2)):
        if c1.0 == c2.0, c1.1 == c2.1 {
            return true
        }
        return false
    default:
        return false
    }
}

struct NetworkCode {

    static let success = 200    // 成功

    static let loginInvalid = 403    // 需要重新登录
    static let loginOntherDevice = 402    // 需要重新登录
    static let roleChanged = 440    // 权限变了，需要重新登录

    static let hadNoMore = 411  // 没有更多数据了

    static let noData = 428   // 没有数据

    static let roleError = 457   // 权限错误

    static let lockByOther = 461    // 被其他人锁定

    static let unLockByOther = 462    // 已经解锁

    static let auditFailed = 466    // 稿件有变化，无法审核

}

