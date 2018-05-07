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
    private let superController: RootController
    private var subController: BrandsListControllerInterface?
    
    //For dependecy injection
    init(superController: RootController, view: MenuListViewInterface, dataProvider: DataProvider<StoreEntity>) {
        self.view = view
        self.dataProvider = dataProvider
        self.superController = superController
        
        self.view.setController(controller: self)
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

extension MenuListController: MenuListControllerInterface{
    func viewDidLoad() {
        self.start()
    }
    
    mutating func viewDidDisappear() {
        self.subController = nil
    }
    
    mutating func didSelectRow(forStore store: StoreEntity) {
        self.subController = BrandsListController(store: store)
    }
    
    func didSelectRowForNews() {
        
    }
    
    func didSelectRowForStatistics() {
        
    }
    
    
}
