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

    var content = Variable<Content?>(nil)
    var listData = Variable<[Row]>([])
    var title = Variable<String>("")
    var alertMessage = Variable<String?>(nil)
    
    var networkService: APIService?

    init(_ apiService: APIService?) {
        
        bindContentData()
        networkService = apiService

        guard let service = apiService else {
            self.alertMessage.value = "APIService is not vaild. Please try refresh it."
            return
        }
        fetchContentInfo(service)
    }
    
    // MARK: Fetch remote data
    fileprivate func fetchContentInfo(_ apiService: APIService?) {
        guard let service = apiService else {
            // This is an universal error.
            // We can't expect user to do things(e.g. refresh screen, reopen app) to recover it.
            // We must make sure APIService is vaild.
            fatalError("Must init an APIService")
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // Observe on background thread.
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
    
    // MARK: Bind remote data to Variables then trigger update UI
    fileprivate func bindContentData() {
        
        // Observe on background thread.
        content.asObservable()
            .observeOn(concurrentScheduler)
            .subscribe(onNext: { content in
                NSLog("current thread: %@, in file: %@, function: %@", Thread.current, #file, #function)
                
                // gain title value
                if let title = content?.title {
                    self.title.value = title
                }

                // gain listData which is from content.rows and will show in UITableview.
                if let listData = content?.rows {
                    let rows = listData.filter {
                        // If all fields are nil, filter out this element
                        return ($0.title != nil) || ($0.descriptionField != nil) || ($0.imageHref != nil)
                    }
                    if rows.isEmpty {
                        self.alertMessage.value = "0 data found."
                        return
                    }
                    self.listData.value = rows
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: self.disposeBag)
    }
    
    // MARK: Re-fetch remote data
    func refreshData() {
        fetchContentInfo(networkService)
    }
}
