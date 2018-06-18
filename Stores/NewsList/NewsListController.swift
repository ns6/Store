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
}

struct NewsListController: NewsListControllerInitInterface {
        
    private let dataProvider: GetDataAPI
    private let presenter: NewsListPresenterProtocol
    
    //For dependecy injection
    init(dataProvider: GetDataAPI, presenter: NewsListPresenterProtocol) {
        self.dataProvider = dataProvider
        self.presenter = presenter
        self.start()
    }
    
    //By default
    init() {
        self.init(dataProvider: DPFactory.dataProvider(), presenter: NewsListPresenter())
    }
    
    private func start() {
        _ = self.presenter.normal
    }
}
