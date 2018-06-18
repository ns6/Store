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
    init(dataProvider: GetDataAPI, presenter: MenuListPresenterProtocol)
}

struct MenuListController: MenuListControllerInitInterface, DPFunctionality {
    
    private let dataProvider: GetDataAPI
    private var presenter: MenuListPresenterProtocol
    
    //For dependecy injection
    init(dataProvider: GetDataAPI, presenter: MenuListPresenterProtocol) {
        self.dataProvider = dataProvider
        self.presenter = presenter
        
        //set callBack
        self.presenter.didSelectStore = { (store) in
            _ = BrandsController(store: store)
        }
        
        self.start()
    }
    
    //By default
    init() {
        self.init(dataProvider: DPFactory.dataProvider(), presenter: MenuListPresenter())
    }
    
    private func start() {
        
        let storePath = EntityPath().Store()
        listen(db: dataProvider, entityPath: storePath, filters: nil, order: nil,
        newData: { (stores: [StoreEntity]) in
            self.presenter.normal.newData(entity: stores)
        }, modifiedData: { (stores: [StoreEntity]) in
            self.presenter.normal.modifiedData(entity: stores)
        }, removedData: { (stores: [StoreEntity]) in
            self.presenter.normal.removedData(entity: stores)
        })
    }
}
