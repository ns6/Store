//
//  BrandsController.swift
//  Stores
//
//  Created by ssion on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation
/*
protocol BrandsListControllerInitInterface {
    init(store: StoreEntity)
    init(presenter: BrandListPresenterInterface & BrandListPresenterSendDataInterface & BrandListPresenterResponseInterface,
         store: StoreEntity,
         dataProvider: DataProvider<BrandEntity>,
         dataProviderForSizesTypes: DataProvider<TypesSizesEntity>)
}

struct BrandsListController: BrandsListControllerInitInterface {

    typealias Presenter = BrandListPresenterInterface & BrandListPresenterSendDataInterface & BrandListPresenterResponseInterface
    
    private let presenter: Presenter
    private var store: StoreEntity
    private let dataProvider: DataProvider<BrandEntity>
    private let dataProviderForSizesTypes: DataProvider<TypesSizesEntity>
    
    //By default
    init(store: StoreEntity) {
        let presenter = BrandListPresenter()
        let dataProvider = DataProviderFactory<BrandEntity>.GetDataProvider.brandsList(storeId: store.id)
        let dataProviderForSizesTypes = DataProviderFactory<TypesSizesEntity>.GetDataProvider.sizesTypesList(storeId: store.id)

        self.init(presenter: presenter,
                  store: store,
                  dataProvider: dataProvider,
                  dataProviderForSizesTypes: dataProviderForSizesTypes)
    }
    
    //For dependecy injection
    init(presenter: Presenter,
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

        //setup presenter
        self.presenter.setViewDidLoad { (view) in
            print("HELLO")
        }.setViewDidDisappear { (view) in
            print("GOOD BY")
        }.setViewDidSelectBrand { (brand) in
            print(brand)
        }

        self.presenter.setViewOption { () -> ViewOptions in
            return .regularView
        }

        dataProviderForSizesTypes.newData { (sizesTypes) in //New data coming

        }.modifiedData { (brands) in //Data modified
            
        }.removedData { (brands) in //Remove data
            
        }.listen()
        
        //.filter(field: "count", isGreaterThan: 0)
        dataProvider.newData { (brands) in //New data coming
            self.presenter.newData(brands)
        }.modifiedData { (brands) in //Data modified
            self.presenter.modifiedData(brands)
        }.removedData { (brands) in //Remove data
            self.presenter.removedData(brands)
        }.listen()
    }
}
*/
