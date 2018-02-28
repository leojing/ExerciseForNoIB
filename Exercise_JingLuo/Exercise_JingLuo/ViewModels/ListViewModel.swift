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
    
    private var networkService: APIService?
    
    var content = Variable<Content?>(nil)
    var listData = Variable<[Row]>([])
    var title = Variable<String>("")
    var alertMessage = Variable<String>("Error")
    
    init(_ apiService: APIService?) {
        bindContentData()
        
        networkService = apiService
        fetchContentInfo(apiService)
    }
    
    fileprivate func fetchContentInfo(_ apiService: APIService?) {
        guard let service = apiService else {
            fatalError("Must init an APIService")
        }
        
        service.fetchFactsInfo(APIConfig.facts)
            .subscribe(onNext: { status in
                switch status {
                case .success(let content):
                    self.content.value = content as? Content
                    
                case .fail(let error):
                    let errorMessage = error.errorDescription ?? "Faild to load remote data"
                    self.alertMessage.value = errorMessage
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
    }
    
    fileprivate func bindContentData() {
        content.asObservable()
            .subscribe(onNext: { content in
                if let listData = content?.rows {
                    self.listData.value = listData
                }
                if let title = content?.title {
                    self.title.value = title
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }
    
    func refreshData() {
        fetchContentInfo(networkService)
    }
}
