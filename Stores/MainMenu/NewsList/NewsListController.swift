//
//  NewsListController.swift
//  Stores
//
//  Created by ssion on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import UIKit

protocol NewsListViewable: class {
    
}

struct NewsListController: RootControllable, NewsListControllable {
    
    weak var view: NewsListViewable!
    
    init(view: NewsListViewable) {
        self.view = view
    }
    
    init() {
        self.init(view: NewsList.storyboardViewController())
    }
    
    //RootControllable:
    func viewController() -> UIViewController {
        return self.view as! UIViewController
    }
}
