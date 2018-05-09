//
//  NewsListController.swift
//  Stores
//
//  Created by ssion on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import UIKit

protocol NewsListControllerInitInterface {
    init()
    init(presenter: NewsListPresenterInterface & NewsListPresenterResponseInterface)
}

struct NewsListController: NewsListControllerInitInterface {
        
    typealias Presenter = NewsListPresenterInterface & NewsListPresenterResponseInterface
    private let presenter: Presenter
    
    //For dependecy injection
    init(presenter: Presenter) {
        self.presenter = presenter
    }
    
    //By default
    init() {
        self.init(presenter: NewsListPresenter())
    }
}
