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
    static var shareInstance: SWRevealViewController?

    static func configure(appDelegate: AppDelegate) {
        FirebaseApp.configure()
        
        let menuListController: RootControllable = MenuListController()
        let newsListController: RootControllable = NewsListController()
        let menuListViewController = menuListController.viewController()
        let newsListViewController = newsListController.viewController()
        let rootViewController = SWRevealViewController(rearViewController: menuListViewController, frontViewController: newsListViewController)

        rootViewController?.setFrontViewPosition(FrontViewPosition.right, animated: false)

        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window?.rootViewController = rootViewController
        appDelegate.window?.makeKeyAndVisible()

        rootViewController?.setFrontViewPosition(FrontViewPosition.left, animated: false)

        self.shareInstance = rootViewController
    }
}
