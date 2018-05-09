//
//  RootController.swift
//  Stores
//
//  Created by Anton Prokuda on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import UIKit

struct RootController {
    static var shareInstance: SWRevealViewController?

    func configure(appDelegate: AppDelegate) {
        guard RootController.shareInstance == nil else { return }
        RootController.shareInstance = SWRevealViewController()
        _ = MenuListController()
        _ = NewsListController()
        
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window?.rootViewController = RootController.shareInstance
        appDelegate.window?.makeKeyAndVisible()
        
        //RootController.shareInstance?.setFrontViewPosition(FrontViewPosition.right, animated: false)
        //RootController.shareInstance?.setFrontViewPosition(FrontViewPosition.left, animated: false)
    }
}
