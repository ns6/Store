//
//  StoreController.swift
//  Stores
//
//  Created by ssion on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import UIKit

protocol MenuListControllerInitInterface {
    init()
    init(presenter: MenuListPresenterInterface & MenuListPresenterSendDataInterface & MenuListPresenterResponseInterface,
         dataProvider: DataProvider<BrandEntity>)
}

struct MenuListController: MenuListControllerInitInterface {
    
    typealias Presenter = MenuListPresenterInterface & MenuListPresenterSendDataInterface & MenuListPresenterResponseInterface
    
    private let presenter: Presenter
    private let dataProvider: DataProvider<StoreEntity>
    private let superController: RootController
    private var subController: Any?
    
    //For dependecy injection
    init(superController: RootController, view: MenuListViewInterface, dataProvider: DataProvider<StoreEntity>) {
        self.dataProvider = dataProvider
        self.superController = superController
        
    }
    
    //By default
    init(superController: RootController) {
        self.init(superController: superController, view: MenuListViewController.storyboardViewController(), dataProvider: DataProviderFactory<StoreEntity>.GetDataProvider.storesList())
    }
    
    private func start() {
        self.dataProvider.newData { (stores) in //New data coming
            self.view.newData(entity: stores)
        }.modifiedData { (stores) in //Data modified
            self.view.modifiedData(entity: stores)
        }.removedData { (stores) in //Remove data
            self.view.removedData(entity: stores)
        }.listen()
    }
}
