//
//  RootController.swift
//  Stores
//
//  Created by Anton Prokuda on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

struct RootController {
    static func configure(appDelegate: AppDelegate) {
        FirebaseApp.configure()
        let leftMenuViewController = LeftMenu.storyboardViewController()
        let newsListViewController = NewsList.storyboardViewController()
        let rootViewController = SWRevealViewController(rearViewController: leftMenuViewController, frontViewController: newsListViewController)

        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.window?.rootViewController = rootViewController
        appDelegate.window?.makeKeyAndVisible()
    }
}
