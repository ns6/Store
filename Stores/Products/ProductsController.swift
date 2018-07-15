//
//  ProductsController.swift
//  Stores
//
//  Created by ssion on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

struct ProductsController: DPFunctionality {
    
    private let dataProvider: GetDataAPI
    private var presenter: Presenter
    private let store: StoreEntity
    private let brand: BrandEntity
    
    //For dependecy injection
    init(dataProvider: GetDataAPI, presenter: Presenter, store: StoreEntity, brand: BrandEntity) {
        self.dataProvider = dataProvider
        self.presenter = presenter
        self.store = store
        self.brand = brand
        
        self.start()
    }
    
    //By default
    init(store: StoreEntity, brand: BrandEntity) {
        let presenter = Presenter(segueType: .push, shouldCreateNavigationController: false)
        presenter.add(viewController: ProductsViewController.self) { (vc) in
            vc.didSelectEntity = { (product) in
                
            }
        }
        
        presenter.add(viewController: EmptyStateViewController.self) { (vc) in
            //to do
        }
        self.init(dataProvider: DPFactory.dataProvider(), presenter: presenter, store: store, brand: brand)
    }
    
    private func start() {
        
        let pathToTypesSizes = EntityPath().Store(value: store.id).SizesTypes()
        listen(db: dataProvider, entityPath: pathToTypesSizes, filters: nil, order: nil,
        newData: { (entity: [TypesSizesEntity]) in

        }, modifiedData: { (entity: [TypesSizesEntity]) in

        }, removedData: { (entity: [TypesSizesEntity]) in

        })
        
        let deadlineTime = DispatchTime.now() + .milliseconds(100)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            if !self.presenter.isPresented {
                let _: EmptyStateViewController = self.presenter.present()
            }
        }
        
        let path = EntityPath().Store(value: store.id).Brand(value: brand.id).Product()
        listen(db: dataProvider, entityPath: path, filters: nil, order: nil,
        newData: { (entity: [ProductEntity]) in
            let vc: ProductsViewController = self.presenter.present()
            vc.newData(entity: entity)
        }, modifiedData: { (entity: [ProductEntity]) in
            let vc: ProductsViewController = self.presenter.present()
            vc.modifiedData(entity: entity)
        }, removedData: { (entity: [ProductEntity]) in
            let vc: ProductsViewController = self.presenter.present()
            vc.removedData(entity: entity)
        })
    }
}
