//
//  BrandsController.swift
//  Stores
//
//  Created by ssion on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

struct BrandsController: DPFunctionality {
    
    private let dataProvider: GetDataAPI
    private let presenter: Presenter
    private let store: StoreEntity
    
    //For dependecy injection
    init(dataProvider: GetDataAPI, presenter: Presenter, store: StoreEntity) {
        self.dataProvider = dataProvider
        self.presenter = presenter
        self.store = store
    
        self.start()
    }
    
    //By default
    init(store: StoreEntity) {
        let presenter = Presenter(segueType: .push, shouldCreateNavigationController: true)
        presenter.add(viewController: BrandsViewController.self) { (vc) in
            vc.didSelectEntity = { (brand) in
                _ = ProductsController(store: store, brand: brand)
            }
        }
        
        presenter.add(viewController: EmptyStateViewController.self) { (vc) in
            //to do
        }
        
        self.init(dataProvider: DPFactory.dataProvider(), presenter: presenter, store: store)
    }
    
    private func start() {
        
//        let pathToTypesSizes = EntityPath().Store(value: store.id).SizesTypes()
//        listen(db: dataProvider, entityPath: pathToTypesSizes, filters: nil, order: nil,
//        newData: { (entity: [TypesSizesEntity]) in
//                
//        }, modifiedData: { (entity: [TypesSizesEntity]) in
//            
//        }, removedData: { (entity: [TypesSizesEntity]) in
//            
//        })
        
        let deadlineTime = DispatchTime.now() + .milliseconds(100)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            if !self.presenter.isPresented {
                let _: EmptyStateViewController = self.presenter.present()
            }
        }
        
        let path = EntityPath().Store(value: store.id).Brand()
        listen(db: dataProvider, entityPath: path, filters: nil, order: nil,
        newData: { (brands: [BrandEntity]) in
            let vc: BrandsViewController = self.presenter.present()
            vc.newData(entity: brands)
        }, modifiedData: { (brands: [BrandEntity]) in
            let vc: BrandsViewController = self.presenter.present()
            vc.modifiedData(entity: brands)
        }, removedData: { (brands: [BrandEntity]) in
            let vc: BrandsViewController = self.presenter.present()
            vc.removedData(entity: brands)
        })
    }
}
