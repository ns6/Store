//
//  StoreController.swift
//  Stores
//
//  Created by ssion on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import UIKit

protocol MenuListViewable: class {
    func newData(stores: [StoreEntity])
    func modifiedData(stores: [StoreEntity])
    func removedData(stores: [StoreEntity])
}

struct MenuListController: RootControllable, MenuListControllable {
    
    weak var view: MenuListViewable!
    private let dataProvider: DataProvider<StoreEntity>!
    
    init(view: MenuListViewable, dataProvider: DataProvider<StoreEntity>) {
        self.view = view
        self.dataProvider = dataProvider
        self.start()
    }
    
    init() {
        self.init(view: MenuList.storyboardViewController(), dataProvider: DataProviderFactory<StoreEntity>.GetDataProvider.storesList())
    }
    
    //RootControllable:
    func viewController() -> UIViewController {
        return self.view as! UIViewController
    }
    
    private func start() {
        self.dataProvider.newData { (stores) in //New data coming
            self.view.newData(stores: stores)
        }.modifiedData { (stores) in //Data modified
            self.view.modifiedData(stores: stores)
        }.removedData { (stores) in //Remove data
            self.view.removedData(stores: stores)
        }.listen()
    }
}
