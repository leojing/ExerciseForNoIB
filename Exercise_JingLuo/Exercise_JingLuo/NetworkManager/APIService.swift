//
//  APIService.swift
//  Exercise_JingLuo
//
//  Created by Jing Luo on 28/2/18.
//  Copyright © 2018 Jing LUO. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum RequestStatus {
    case success(Any)
    case fail(RequestError)
}

struct RequestError : LocalizedError {
    
    var errorDescription: String? { return mMsg }
    var failureReason: String? { return mMsg }
    var recoverySuggestion: String? { return "" }
    var helpAnchor: String? { return "" }
    
    private var mMsg : String
    
    init(_ description: String) {
        mMsg = description
    }
}

enum APIConfig  {
    case facts
}

extension APIConfig {
    
    var baseURL: String {
        switch self {
        case .facts:
            return "https://dl.dropboxusercontent.com"
        }
    }
    
    var path: String {
        switch self {
        case .facts:
            return "/s/2iodh4vg0eortkl/facts.json"
        }
    }
    
    var method: String {
        switch self {
        case .facts:
            return "GET"
        }
    }
    
    var header: [String: Any]?{
        switch self {
        case .facts:
            return nil
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .facts:
            return nil
        }
    }

    func getFullURL() -> URL {
        switch self {
        case .facts:
            if let url = URL(string: baseURL + path) {
                return url
            }
            return URL(string: baseURL)!
        }
    }
}

protocol APIService {
    func fetchFactsInfo(_ config: APIConfig) -> Observable<RequestStatus>
    func networkRequest(_ config: APIConfig, completionHandler: @escaping ((_ jsonResponse: [String: Any]?, _ error: RequestError?) -> Void))
}

