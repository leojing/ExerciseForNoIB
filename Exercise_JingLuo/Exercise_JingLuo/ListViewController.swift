//
//  ViewController.swift
//  Exercise_JingLuo
//
//  Created by Jing Luo on 22/2/18.
//  Copyright © 2018 Jing LUO. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    private var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView = UITableView(frame: view.bounds, style: .grouped)
        myTableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseId())
        view.addSubview(myTableView)
    }
}

