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
        myTableView = UITableView(frame: view.bounds, style: .grouped)
        myTableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseId())
        view.addSubview(myTableView)
    }
    
    fileprivate func setupViewModelBinds() {
        viewModel?.title.asObservable()
            .subscribe(onNext: { title in
                self.navigationController?.title = title
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
        
        viewModel?.listData.asObservable()
            .bind(to: myTableView.rx.items(cellIdentifier: DetailTableViewCell.reuseId(), cellType: DetailTableViewCell.self)) { (row, element, cell) in
                cell.configureCell(element)
                //DetailCellDisplayModel(title: element.title, imageURL: element.imageHref, description: element.description)
            }
            .disposed(by: disposeBag)
        
        // MARK: show error message
        viewModel?.alertMessage.asObservable()
            .subscribe(onNext: { errorMessage in
                self.showAlert(errorMessage)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }
    
    // MARK: Actions
    fileprivate func refreshAction() {
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

