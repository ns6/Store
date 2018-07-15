//
//  NewsListController.swift
//  Stores
//
//  Created by ssion on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import UIKit

struct NewsListController {
        
    private let dataProvider: GetDataAPI
    private let presenter: Presenter
    
    //For dependecy injection
    init(dataProvider: GetDataAPI, presenter: Presenter) {
        self.dataProvider = dataProvider
        self.presenter = presenter
        self.start()
    }
    
    //By default
    init() {
        let presenter = Presenter(segueType: .push, shouldCreateNavigationController: true)
        presenter.add(viewController: NewsListViewController.self) { (vc) in
            //to do
        }
        self.init(dataProvider: DPFactory.dataProvider(), presenter: presenter)
    }
    
    private func start() {
        let vc: NewsListViewController = self.presenter.present()
    }
}
