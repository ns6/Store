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

struct RootController {
    static var shareInstance: SWRevealViewController?

    func configure(appDelegate: AppDelegate) {
        guard RootController.shareInstance == nil else { return }
        
        FirebaseApp.configure()

        let rootViewController = SWRevealViewController(rearViewController: MenuListController(superController: self).view as! UIViewController, frontViewController: NewsListController().view as! UIViewController)

        rootViewController?.setFrontViewPosition(FrontViewPosition.right, animated: false)

        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window?.rootViewController = rootViewController
        appDelegate.window?.makeKeyAndVisible()

        rootViewController?.setFrontViewPosition(FrontViewPosition.left, animated: false)

        RootController.shareInstance = rootViewController
    }
}
