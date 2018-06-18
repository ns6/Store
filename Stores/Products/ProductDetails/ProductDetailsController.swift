//
//  ProductDetailsController.swift
//  Stores
//
//  Created by ssion on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol ProductDetailsControllerProtocol {
    init(store: StoreEntity, brand: BrandEntity, product: ProductEntity)
    init(dataProvider: GetDataAPI, presenter: ProductDetailsPresenterProtocol, store: StoreEntity, brand: BrandEntity, product: ProductEntity)
}

struct ProductDetailsController: ProductDetailsControllerProtocol, DPFunctionality {
    
    private let dataProvider: GetDataAPI
    private var presenter: ProductDetailsPresenterProtocol
    private let store: StoreEntity
    private let brand: BrandEntity
    private let product: ProductEntity
    
    //For dependecy injection
    init(dataProvider: GetDataAPI, presenter: ProductDetailsPresenterProtocol, store: StoreEntity, brand: BrandEntity, product: ProductEntity) {
        self.dataProvider = dataProvider
        self.presenter = presenter
        self.store = store
        self.brand = brand
        
        //set callBack
        self.presenter.didSelectBrand = { (product) in
            print(product)
        }
        
        self.start()
    }
    
    //By default
    init(store: StoreEntity, brand: BrandEntity, product: ProductEntity) {
        self.init(dataProvider: DPFactory.dataProvider(), presenter: ProductDetailsPresenter(), store: store, brand: brand)
    }
    
    private func start() {
        //_ = self.presenter.empty
        
        let pathToTypesSizes = EntityPath().Store(value: store.id).SizesTypes()
        listen(db: dataProvider, entityPath: pathToTypesSizes, filters: nil, order: nil,
               newData: { (entity: [TypesSizesEntity]) in
                
        }, modifiedData: { (entity: [TypesSizesEntity]) in
            
        }, removedData: { (entity: [TypesSizesEntity]) in
            
        })
        
        let path = EntityPath().Store(value: store.id).Brand(value: brand.id).Product()
        listen(db: dataProvider, entityPath: path, filters: nil, order: nil,
               newData: { (entity: [ProductEntity]) in
                self.presenter.normal.newData(entity: entity)
        }, modifiedData: { (entity: [ProductEntity]) in
            self.presenter.normal.modifiedData(entity: entity)
        }, removedData: { (entity: [ProductEntity]) in
            self.presenter.normal.removedData(entity: entity)
        })
    }
}
