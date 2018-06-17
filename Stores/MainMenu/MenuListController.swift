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
    init(presenter: Presenter, dataProvider: GetDataAPI)
}

struct MenuListController: MenuListControllerInitInterface, DPFunctionality {
    
    private let dataProvider: GetDataAPI
    private let vcFactory: VCFactoryProtocol
    private var emptyVC: EmptyStateViewController {
        return vcFactory.getViewController()
    }
    private var mainVC: MenuListViewController {
        return vcFactory.getViewController()
    }
    
    //For dependecy injection
    init(dataProvider: GetDataAPI, vcFactory: VCFactoryProtocol) {
        self.dataProvider = dataProvider
        self.vcFactory = vcFactory
        self.start()
    }
    
    //By default
    init() {
        self.init(dataProvider: DPFactory.dataProvider(), vcFactory: VCFactory())
    }
    
    private func start() {
        let storePath = EntityPath().Store()
        listen(db: dataProvider, entityPath: storePath, filters: nil, order: nil,
        newData: { (stores: [StoreEntity]) in
            
        }, modifiedData: { (stores: [StoreEntity]) in
            
        }, removedData: { (stores: [StoreEntity]) in

        })
    }
}
