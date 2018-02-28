//
//  AppDelegate.swift
//  Exercise_JingLuo
//
//  Created by Jing Luo on 22/2/18.
//  Copyright © 2018 Jing LUO. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let rootViewController = ListViewController(nibName: nil, bundle: nil)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        if let window = window {
            window.rootViewController = navigationController
        }
        return true
    }
}

