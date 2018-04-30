//
//  BrandsController.swift
//  Stores
//
//  Created by ssion on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

struct BrandsListController {

    weak var view: BrandsListViewInterface!
    private var store: StoreEntity
    private var dataProvider: DataProvider<BrandEntity>
    private var dataProviderForSizesTypes: DataProvider<TypesSizesEntity>
    
    //For dependecy injection
    init(view: BrandsListViewInterface,
         store: StoreEntity,
         dataProvider: DataProvider<BrandEntity>,
         dataProviderForSizesTypes: DataProvider<TypesSizesEntity>) {
        self.view = view
        self.store = store
        self.dataProvider = dataProvider
        self.dataProviderForSizesTypes = dataProviderForSizesTypes
        self.view.setController(controller: self)
        self.start()
    }
    
    //By default
    init(store: StoreEntity) {
        let dataProvider = DataProviderFactory<BrandEntity>.GetDataProvider.brandsList(storeId: store.id)
        let dataProviderForSizesTypes = DataProviderFactory<TypesSizesEntity>.GetDataProvider.sizesTypesList(storeId: store.id)
        self.init(view: BrandsListViewController.storyboardViewController(),
                 store: store,
                  dataProvider: dataProvider,
                  dataProviderForSizesTypes: dataProviderForSizesTypes)
    }
    
    private func start() {
        RootController.shareInstance?.setFrontViewPosition(FrontViewPosition.left, animated: false)
        RootController.shareInstance?.pushFrontViewController(self.view as! UIViewController, animated: true)

        dataProviderForSizesTypes.newData { (sizesTypes) in //New data coming

        }.modifiedData { (brands) in //Data modified
            
        }.removedData { (brands) in //Remove data
            
        }.listen()
        
        //.filter(field: "count", isGreaterThan: 0)
        dataProvider.newData { (brands) in //New data coming
            self.view.newData(entity: brands)
        }.modifiedData { (brands) in //Data modified
            self.view.modifiedData(entity: brands)
        }.removedData { (brands) in //Remove data
            self.view.removedData(entity: brands)
        }.listen()
    }
}

extension BrandsListController: BrandsListControllerInterface {
    func didSelectRow(forBrand brand: BrandEntity) {
        
    }
    
    func didSelectRowForNews() {

    }
    
    func didSelectRowForStatistics() {

    }
    
    
}
