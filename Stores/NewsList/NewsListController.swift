//
//  NewsListController.swift
//  Stores
//
//  Created by ssion on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import UIKit

struct NewsListController: NewsListControllerInterface {
        
    weak var view: NewsListViewInterface!
    
    //For dependecy injection
    init(view: NewsListViewInterface) {
        self.view = view
        self.view.setController(controller: self)
    }
    
    //By default
    init() {
        self.init(view: NewsListViewController.storyboardViewController())
    }
}

extension NewsListController: RootControllable {
    func viewController() -> UIViewController {
        return self.view as! UIViewController
    }
}
