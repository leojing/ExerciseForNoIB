//
//  APIClient.swift
//  Exercise_JingLuo
//
//  Created by Jing Luo on 28/2/18.
//  Copyright © 2018 Jing LUO. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import AFNetworking
import ObjectMapper

class APIClient: APIService {
    
    func fetchWeatherInfo(_ config: APIConfig) -> Observable<RequestStatus> {
        return Observable<RequestStatus>.create { observable -> Disposable in
            self.networkRequest(config, completionHandler: { (json, error) in
                guard let json = json else {
                    if let error = error {
                        observable.onNext(RequestStatus.fail(error))
                    } else {
                        observable.onNext(RequestStatus.fail(RequestError("Parse Content information failed.")))
                    }
                    observable.onCompleted()
                    return
                }
                if let content = Mapper<Content>().map(JSON: json) {
                    observable.onNext(RequestStatus.success(content))
                    observable.onCompleted()
                } else {
                    observable.onNext(RequestStatus.fail(RequestError("Parse Content information failed.")))
                    observable.onCompleted()
                }
            })
            return Disposables.create()
            }.share()
    }
    
    // MARK: conform to APIService protocol. For new class inherit from APIClient class, you can overwrite this function and use any other HTTP networking libraries. Like in Unit test, I create MockAPIClient which request network by load local JSON file.
    func networkRequest(_ config: APIConfig, completionHandler: @escaping ((_ jsonResponse: [String: Any]?, _ error: RequestError?) -> Void)) {
        if let isConnected = Connectivity.isConnectedToInternet, isConnected {
            return completionHandler(nil, RequestError("Internet Not Available"))
        }
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()

        let url = config.getFullURL()
        if config.method == "GET" {
            manager.get(url.absoluteString, parameters: config.parameters, progress: nil, success: { (task, response) in
                self.networkResponseSuccess(task, response, completionHandler)
            }, failure: { (task: URLSessionDataTask?, error) in
                completionHandler(nil, RequestError(error.localizedDescription))
                return
            })
        }
        // here you can add other request task like POST, DELET... based on APIConfig's method value
    }
    
    fileprivate func networkResponseSuccess(_ task: URLSessionDataTask, _ response: Any?, _ completionHandler: ((_ jsonResponse: [String: Any]?, _ error: RequestError?) -> Void)) {
        guard let json = response as? [String: Any] else {
            NSLog("Error: \(String(describing: response.debugDescription))")
            completionHandler(nil, RequestError(response.debugDescription))
            return
        }

        completionHandler(json, nil)
    }
}

class Connectivity {
    class var isConnectedToInternet: Bool? {
        return AFNetworkReachabilityManager().isReachable
    }
}

