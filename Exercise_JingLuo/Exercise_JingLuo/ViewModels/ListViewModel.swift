//
//  ListViewModel.swift
//  Exercise_JingLuo
//
//  Created by Jing Luo on 28/2/18.
//  Copyright © 2018 Jing LUO. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ListViewModel {
    let disposeBag = DisposeBag()
    private let concurrentScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    private var networkService: APIService?

    var content = Variable<Content?>(nil)
    var listData = Variable<[Row]>([])
    var title = Variable<String>("")
    var alertMessage = Variable<String?>(nil)
    
    init(_ apiService: APIService?) {
        bindContentData()
        
        networkService = apiService
        fetchContentInfo(apiService)
    }
    
    fileprivate func fetchContentInfo(_ apiService: APIService?) {
        guard let service = apiService else {
            fatalError("Must init an APIService")
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        service.fetchFactsInfo(APIConfig.facts)
            .observeOn(concurrentScheduler)
            .subscribe(onNext: { status in
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                switch status {
                case .success(let content):
                    self.content.value = content as? Content
                    
                case .fail(let error):
                    let errorMessage = error.errorDescription ?? "Faild to load remote data."
                    self.alertMessage.value = errorMessage
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
    }
    
    fileprivate func bindContentData() {
        content.asObservable()
            .observeOn(concurrentScheduler)
            .subscribe(onNext: { content in
                NSLog("current thread: %@, in file: %@, function: %@", Thread.current, #file, #function)
                if let listData = content?.rows {
                    self.listData.value = listData.filter {
                        return ($0.title != nil) || ($0.descriptionField != nil) || ($0.imageHref != nil)
                    }
                }
                if let title = content?.title {
                    self.title.value = title
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: self.disposeBag)
    }
    
    func refreshData() {
        fetchContentInfo(networkService)
    }
}
