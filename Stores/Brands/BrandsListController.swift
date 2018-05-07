//
//  BrandsController.swift
//  Stores
//
//  Created by ssion on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol BrandsListControllerInitInterface {
    init(store: StoreEntity)
    init(presenter: BrandListPresenterInterface,
         store: StoreEntity,
         dataProvider: DataProvider<BrandEntity>,
         dataProviderForSizesTypes: DataProvider<TypesSizesEntity>)
}

struct BrandsListController: BrandsListControllerInitInterface {

    private let presenter: BrandListPresenterInterface
    private var store: StoreEntity
    private let dataProvider: DataProvider<BrandEntity>
    private let dataProviderForSizesTypes: DataProvider<TypesSizesEntity>
    
    //By default
    init(store: StoreEntity) {
        let dataProvider = DataProviderFactory<BrandEntity>.GetDataProvider.brandsList(storeId: store.id)
        let dataProviderForSizesTypes = DataProviderFactory<TypesSizesEntity>.GetDataProvider.sizesTypesList(storeId: store.id)
        self.init(presenter: BrandListPresenter(),
                  store: store,
                  dataProvider: dataProvider,
                  dataProviderForSizesTypes: dataProviderForSizesTypes)
    }
    
    //For dependecy injection
    init(presenter: BrandListPresenterInterface,
         store: StoreEntity,
         dataProvider: DataProvider<BrandEntity>,
         dataProviderForSizesTypes: DataProvider<TypesSizesEntity>) {
        self.presenter = presenter
        self.store = store
        self.dataProvider = dataProvider
        self.dataProviderForSizesTypes = dataProviderForSizesTypes
        self.start()
    }
    
    private func start() {

        dataProviderForSizesTypes.newData { (sizesTypes) in //New data coming

        }.modifiedData { (brands) in //Data modified
            
        }.removedData { (brands) in //Remove data
            
        }.listen()
        
        //.filter(field: "count", isGreaterThan: 0)
        dataProvider.newData { (brands) in //New data coming
            self.presenter.newData(brands)
            //self.view?.newData(entity: brands)
        }.modifiedData { (brands) in //Data modified
            //self.view?.modifiedData(entity: brands)
        }.removedData { (brands) in //Remove data
            //self.view?.removedData(entity: brands)
        }.listen()
    }
}

extension BrandsListController: BrandsListControllerInterface {
    func viewDidLoad() {
//        self.start()
    }
    
    func viewDidDisappear() {
        
    }
    
    func didSelectRow(forBrand brand: BrandEntity) {
        
    }
}
