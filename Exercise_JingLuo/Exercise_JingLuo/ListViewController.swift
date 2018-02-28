//
//  ViewController.swift
//  Exercise_JingLuo
//
//  Created by Jing Luo on 22/2/18.
//  Copyright © 2018 Jing LUO. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Masonry

class ListViewController: UIViewController {

    private var myTableView: UITableView!
    
    fileprivate let disposeBag = DisposeBag()
    var viewModel: ListViewModel? {
        didSet {
            setupViewModelBinds()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel = ListViewModel(APIClient())
    }
    
    fileprivate func setupUI() {
        let refreshButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshAction))
        navigationItem.rightBarButtonItem = refreshButtonItem
        
        setUpTableView()
    }
    
    private func setUpTableView() {
        myTableView = UITableView(frame: .zero, style: .plain)
        myTableView.separatorStyle = .none
        myTableView.estimatedRowHeight = 100
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseId())
        view.addSubview(myTableView)
        
        myTableView.mas_makeConstraints { make in
            make?.top.equalTo()(self.view.mas_top)?.with().offset()(0)
            make?.bottom.equalTo()(self.view.mas_bottom)?.with().offset()(0)
            make?.right.equalTo()(self.view.mas_right)?.with().offset()(0)
            make?.left.equalTo()(self.view.mas_left)?.with().offset()(0)
        }
    }
    
    fileprivate func setupViewModelBinds() {
        viewModel?.title.asObservable()
            .observeOn(MainScheduler())
            .subscribe(onNext: { title in
                self.title = title
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
        
        viewModel?.listData.asObservable()
            .bind(to: myTableView.rx.items(cellIdentifier: DetailTableViewCell.reuseId(), cellType: DetailTableViewCell.self)) { (row, element, cell) in
                NSLog("current thread: %@, in file: %@, function: %@", Thread.current, #file, #function)
                cell.configureCell(element)
            }
            .disposed(by: disposeBag)
        
        // MARK: show error message
        viewModel?.alertMessage.asObservable()
            .filter{$0 != nil}
            .subscribe(onNext: { errorMessage in
                self.showAlert(errorMessage!)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }
    
    // MARK: Actions
    @objc fileprivate func refreshAction() {
        viewModel?.refreshData()
    }
    
    fileprivate func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

}

