//
//  NetworkProvider.swift
//  pronhub
//
//  Created by Gesantung on 2019/5/21.
//  Copyright © 2019 laofeng. All rights reserved.
//

import Foundation

import Alamofire
import Moya
import RxSwift

class NetworkProvider<Target> where Target: Moya.TargetType {

    private let provider: MoyaProvider<Target>

    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = NetworkProvider.endpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = NetworkProvider.stubBehavior,
         manager: Manager = NetworkProvider.sessionManager(),
         plugins: [PluginType] = [NetworkLogger(), NetWorkServerErrorFilter.share],
         trackInflights: Bool = false) {
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }

    func request(_ target: Target) -> Observable<Moya.Response> {
        return provider.rx.request(target).asObservable()
    }

}

typealias NetworkSuccess<T> = (T) -> Void

typealias NetworkFailed = (CollectorError) -> Void
typealias NetworkAlways = () -> Void

extension NetworkProvider {
    @discardableResult
    func request<T: Decodable>(_ target: Target, success: @escaping NetworkSuccess<T>, failed: @escaping NetworkFailed) -> Cancellable {
        return provider.request(target) { (result) in
            switch result {
            case .success(let response):
                do {
                    let object = try Network.decodableObject(data: response.data, type: T.self)
                    success(object)
                } catch CollectorError.server(let code, let messge) {
                    failed(CollectorError.server(code, messge))
                } catch {
                    #if DEBUG
                    failed(CollectorError.custom("服务器返回数据异常: \(target.path)"))
                    #else
                    failed(CollectorError.badData)
                    #endif
                }
            case .failure(let error):
                if let response = error.response {
                    if response.statusCode == NSURLErrorTimedOut {
                        failed(CollectorError.timeOut)
                        return
                    }
                }
                failed(CollectorError.offline)
            }
        }
    }

    @discardableResult
    func requestVoid(_ target: Target, success: @escaping NetworkSuccess<NetModel>, failed: @escaping NetworkFailed) -> Cancellable {
        return provider.request(target) { (result) in
            switch result {
            case .success(let response):
                do {
                    let object = try Network.decodableObject(data: response.data, type: NetModel.self, keyPath: "")
                    success(object)
                } catch CollectorError.server(let code, let messge) {
                    failed(CollectorError.server(code, messge))
                } catch {
                    #if DEBUG
                    failed(CollectorError.custom("服务器返回数据异常: \(target.path)"))
                    #else
                    failed(CollectorError.badData)
                    #endif
                }
            case .failure(let error):
                if let response = error.response {
                    if response.statusCode == NSURLErrorTimedOut {
                        failed(CollectorError.timeOut)
                        return
                    }
                }
                failed(CollectorError.offline)
            }
        }
    }

    //data字段下是array的情况
    @discardableResult
    func requstArray<T: Decodable>(_ target: Target, success: @escaping NetworkSuccess<[T]>, failed: @escaping NetworkFailed) -> Cancellable {
        return provider.request(target) { (result) in
            switch result {
            case .success(let response):
                do {
                    let object = try Network.decodableArrayObject(data: response.data, type: T.self)
                    success(object)
                } catch CollectorError.server(let code, let messge) {
                    failed(CollectorError.server(code, messge))
                } catch {
                    #if DEBUG
                    failed(CollectorError.custom("服务器返回数据异常: \(target.path)"))
                    #else
                    failed(CollectorError.badData)
                    #endif
                }

            case .failure(let error):
                if let response = error.response {
                    if response.statusCode == NSURLErrorTimedOut {
                        failed(CollectorError.timeOut)
                        return
                    }
                }
                failed(CollectorError.offline)
            }

        }
    }

}

struct NetModel: Decodable {
    let message: String
    let status: Int

    var isSucceed: Bool {
        return 200 == status
    }
}

public extension ObservableType where E == Response {

    //data字段为空（或者值没有意义）时，使用 MapVoid()
    public func mapVoid() -> Observable<Void> {
        return mapToModel(NetModel.self, keyPath: "").map { _ in Void() }
    }

    public func mapToModel<T: Decodable>(_: T.Type, decoder: JSONDecoder = JSONDecoder.init(), keyPath: String = "data") -> Observable<T> {

        return map({ (response) -> T in
            let objcet = try Network.decodableObject(data: response.data, type: T.self, decoder: decoder, keyPath: keyPath)
            return objcet
        }).catchError { (err) -> Observable<T> in
            // 捕获错误，转换为CollectorError
            return Observable<T>.create({ (observe) -> Disposable in
                var finalError = CollectorError.offline
                if let error = err as? MoyaError, let reponse = error.response {
                    if reponse.statusCode == NSURLErrorTimedOut {
                        finalError = CollectorError.timeOut
                    }
                } else if let error = err as? CollectorError {
                    finalError = error
                }
                observe.onError(finalError)
                return Disposables.create()
            })}
    }

    public func mapToArrayModel<T: Decodable>(_: T.Type, decoder: JSONDecoder = JSONDecoder.init(), keyPath: String = "data") -> Observable<[T]> {

        return map({ (response) -> [T] in
            let objcet = try Network.decodableArrayObject(data: response.data, type: T.self, decoder: decoder, keyPath: keyPath)
            return objcet
        }).catchError { (err) -> Observable<[T]> in
            // 捕获错误，转换为CollectorError
            return Observable<[T]>.create({ (observe) -> Disposable in
                var finalError = CollectorError.offline
                if let error = err as? MoyaError, let reponse = error.response {
                    if reponse.statusCode == NSURLErrorTimedOut {
                        finalError = CollectorError.timeOut
                    }
                } else if let error = err as? CollectorError {
                    finalError = error
                }
                observe.onError(finalError)
                return Disposables.create()
            })}
    }

}

extension NetworkProvider {

    static func endpointMapping(_ target: Target) -> Endpoint {
        return Endpoint(
            url: "\(URL(target: target).absoluteString)?vno=\(APIContext.version)",
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }

    static func stubBehavior(target: Target) -> Moya.StubBehavior {
        if canStub && stubWhiteList.contains(target.path) {
            return .immediate
        }
        return .never
    }

    static func sessionManager() -> Manager {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            globalAPIEnvironment.rawValue: .pinCertificates(certificates: ServerTrustPolicy.certificates(), validateCertificateChain:true, validateHost:false)
        ]
        let sessionDelegate = SessionDelegate()
        let  _manager = SessionManager.init(configuration: configuration, delegate: sessionDelegate, serverTrustPolicyManager: ServerTrustPolicyManager.init(policies: serverTrustPolicies))
        sessionDelegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
            var credential: URLCredential?
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = URLSession.AuthChallengeDisposition.useCredential
                credential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .cancelAuthenticationChallenge
                } else {
                    if let cr = _manager.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace) {
                        disposition = .useCredential
                        credential = cr
                    }
                }
            }
            return (disposition, credential)
        }
        return _manager
    }

}

