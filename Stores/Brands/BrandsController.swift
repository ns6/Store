//
//  BrandsController.swift
//  Stores
//
//  Created by ssion on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol BrandsControllerProtocol {
    init(store: StoreEntity)
    init(dataProvider: GetDataAPI, presenter: BrandsPresenterProtocol, store: StoreEntity)
}

struct BrandsController: BrandsControllerProtocol, DPFunctionality {
    
    private let dataProvider: GetDataAPI
    private var presenter: BrandsPresenterProtocol
    private let store: StoreEntity
    
    //For dependecy injection
    init(dataProvider: GetDataAPI, presenter: BrandsPresenterProtocol, store: StoreEntity) {
        self.dataProvider = dataProvider
        self.presenter = presenter
        self.store = store
        
        //set callBack
        self.presenter.didSelectBrand = { (brand) in
            _ = ProductsController(store: store, brand: brand)
        }
        
        self.start()
    }
    
    //By default
    init(store: StoreEntity) {
        self.init(dataProvider: DPFactory.dataProvider(), presenter: BrandPresenter(), store: store)
    }
    
    private func start() {
        _ = self.presenter.empty
        
//        let pathToTypesSizes = EntityPath().Store(value: store.id).SizesTypes()
//        listen(db: dataProvider, entityPath: pathToTypesSizes, filters: nil, order: nil,
//        newData: { (entity: [TypesSizesEntity]) in
//                
//        }, modifiedData: { (entity: [TypesSizesEntity]) in
//            
//        }, removedData: { (entity: [TypesSizesEntity]) in
//            
//        })
        
        let path = EntityPath().Store(value: store.id).Brand()
        listen(db: dataProvider, entityPath: path, filters: nil, order: nil,
        newData: { (brand: [BrandEntity]) in
            self.presenter.normal.newData(entity: brand)
        }, modifiedData: { (brand: [BrandEntity]) in
            self.presenter.normal.modifiedData(entity: brand)
        }, removedData: { (brand: [BrandEntity]) in
            self.presenter.normal.removedData(entity: brand)
        })
    }
}
