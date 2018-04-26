//
//  RootController.swift
//  Stores
//
//  Created by Anton Prokuda on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

protocol RootControllable {
    func viewController() -> UIViewController
}

struct RootController {
    static func configure(appDelegate: AppDelegate) {
        FirebaseApp.configure()
        
        let storesListController: RootControllable = StoresListController()
        let newsListController: RootControllable = NewsListController()
        let leftMenuViewController = LeftMenu.storyboardViewController()
        let newsListViewController = newsListController.viewController()
        let rootViewController = SWRevealViewController(rearViewController: leftMenuViewController, frontViewController: newsListViewController)

        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window?.rootViewController = rootViewController
        appDelegate.window?.makeKeyAndVisible()
    }
}
