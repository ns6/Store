//
//  StoreController.swift
//  Stores
//
//  Created by ssion on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import UIKit

struct MenuListController {
    
    weak var view: MenuListViewInterface!
    private let dataProvider: DataProvider<StoreEntity>
    
    //For dependecy injection
    init(view: MenuListViewInterface, dataProvider: DataProvider<StoreEntity>) {
        self.view = view
        self.dataProvider = dataProvider
        self.view.setController(controller: self)
        self.start()
    }
    
    //By default
    init() {
        self.init(view: MenuListViewController.storyboardViewController(), dataProvider: DataProviderFactory<StoreEntity>.GetDataProvider.storesList())
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

extension MenuListController: RootControllable {
    func viewController() -> UIViewController {
        return self.view as! UIViewController
    }
}

extension MenuListController: MenuListControllerInterface{
    func didSelectRow(forStore store: StoreEntity) {
        
    }
    
    func didSelectRowForNews() {
        
    }
    
    func didSelectRowForStatistics() {
        
    }
    
    
}
