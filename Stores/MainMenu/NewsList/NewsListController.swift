//
//  NewsListController.swift
//  Stores
//
//  Created by ssion on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import UIKit

protocol NewsListControllable {
    var instance: UIViewController {get}
    
}

struct NewsListController: RootControllable, NewsListViewable {
    
    let view: NewsListControllable
    
    init(view: NewsListControllable) {
        self.view = view
    }
    
    init() {
        self.view = NewsList()
    }
    
    //RootControllable:
    func viewController() -> UIViewController {
        return self.view.instance
    }
}
