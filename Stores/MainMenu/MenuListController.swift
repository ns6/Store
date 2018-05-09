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
         dataProvider: DataProvider<StoreEntity>)
}

struct MenuListController: MenuListControllerInitInterface {
    
    typealias Presenter = MenuListPresenterInterface & MenuListPresenterSendDataInterface & MenuListPresenterResponseInterface
    
    private let presenter: Presenter
    private let dataProvider: DataProvider<StoreEntity>
    
    //For dependecy injection
    init(presenter: Presenter, dataProvider: DataProvider<StoreEntity>) {
        self.presenter = presenter
        self.dataProvider = dataProvider
        
        self.start()
    }
    
    //By default
    init() {
        self.init(presenter: MenuListPresenter(), dataProvider: DataProviderFactory<StoreEntity>.GetDataProvider.storesList())
    }
    
    private func start() {
        
        //setup presenter
        self.presenter.setViewDidLoad { (view) in
            print("HELLO")
        }.setViewDidDisappear { (view) in
            print("GOOD BY")
        }.setViewDidSelectStore { (store) in
            BrandsListController(store: store)
        }
        
        self.dataProvider.newData { (stores) in //New data coming
            self.presenter.newData(stores)
        }.modifiedData { (stores) in //Data modified
            self.presenter.modifiedData(stores)
        }.removedData { (stores) in //Remove data
            self.presenter.removedData(stores)
        }.listen()
    }
}
