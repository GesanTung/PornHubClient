//
//  NetworkDecode.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/21.
//  Copyright © 2019 laofeng. All rights reserved.
//

import Foundation

struct Network {

    static func decodableObject<T: Decodable>(data: Data, type: T.Type, decoder: JSONDecoder = JSONDecoder.init(), keyPath: String = "data") throws -> T {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let object = try? decoder.decode(NetModel.self, from: data) else {
                #if DEBUG
                throw CollectorError.custom("服务器返回数据异常: \(type)")
                #else
                throw CollectorError.badData
                #endif
        }
        if object.isSucceed {
            do {
                if keyPath.isEmpty {
                    return try decoder.decode(T.self, from: data)
                } else if let nestedJson = (json as AnyObject).value(forKeyPath: keyPath) {
                    let nestedData = try JSONSerialization.data(withJSONObject: nestedJson)
                    return try decoder.decode(T.self, from: nestedData)
                }
            } catch let e {
                #if DEBUG
                debugPrint(e)
                throw CollectorError.custom("服务器返回数据异常: \(e)")
                #else
                throw CollectorError.badData
                #endif
            }
        } else {
            throw CollectorError.server(object.status, object.message)
        }
        throw CollectorError.badData
    }

    static func decodableArrayObject<T: Decodable>(data: Data, type: T.Type, decoder: JSONDecoder = JSONDecoder.init(), keyPath: String = "data") throws -> [T] {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let object = try? decoder.decode(NetModel.self, from: data) else {
                #if DEBUG
                throw CollectorError.custom("服务器返回数据异常: \(type)")
                #else
                throw CollectorError.badData
                #endif
        }
        if object.isSucceed {
            do {
                if let nestedJsons = ((json as Any) as AnyObject).value(forKeyPath: keyPath) as? NSArray {
                    var nestedObjs: [T] = []
                    for nestedJson in nestedJsons {
                        let nestedData = try JSONSerialization.data(withJSONObject: nestedJson)
                        let nestedObj = try decoder.decode(T.self, from: nestedData)
                        nestedObjs.append(nestedObj)
                    }
                    return nestedObjs
                }
            } catch let e {
                #if DEBUG
                debugPrint(e)
                throw CollectorError.custom("服务器返回数据异常: \(e)")
                #else
                throw CollectorError.badData
                #endif
            }
        } else {
            throw CollectorError.server(object.status, object.message)
        }
        throw CollectorError.badData
    }

}
