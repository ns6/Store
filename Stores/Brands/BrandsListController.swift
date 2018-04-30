//
//  BrandsController.swift
//  Stores
//
//  Created by ssion on 4/25/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

struct BrandsListController {
    
    private var store: StoreEntity
    private var sizesTypes: [TypesSizesEntity]?
    private var dataProvider: DataProvider<BrandEntity>
    private var dataProviderForSizesTypes: DataProvider<TypesSizesEntity>
    
    //For dependecy injection
    init(store: StoreEntity,
         dataProvider: DataProvider<BrandEntity>,
         dataProviderForSizesTypes: DataProvider<TypesSizesEntity>) {
        self.store = store
        self.dataProvider = dataProvider
        self.dataProviderForSizesTypes = dataProviderForSizesTypes
    }
    
    //By default
    init(store: StoreEntity) {
        let dataProvider = DataProviderFactory<BrandEntity>.GetDataProvider.brandsList(storeId: store.id)
        let dataProviderForSizesTypes = DataProviderFactory<TypesSizesEntity>.GetDataProvider.sizesTypesList(storeId: store.id)
        self.init(store: store,
                  dataProvider: dataProvider,
                  dataProviderForSizesTypes: dataProviderForSizesTypes)
    }
    
    private mutating func start(this: BrandsListController) {
        dataProviderForSizesTypes.newData { (sizesTypes) in //New data coming
            this.sizesTypes = sizesTypes
        }.modifiedData { (brands) in //Data modified
            
        }.removedData { (brands) in //Remove data
            
        }.listen()
        
        //.filter(field: "count", isGreaterThan: 0)
        dataProvider.newData { [unowned self] (brands) in //New data coming
            self.store.addBrands(brands)
            self.tableDirector.insert(cellType: BrandCellView.self, items: brands, inSection: 0, withUpdate: .top, configure: { (cell) in
                cell.on(.click) { (options) in
                    //return true
                    }
                    .on(.canEdit) { (options) -> Bool in
                        return true
                }
                //                        .on(.clickDelete) { [weak self] (options) in
                //                            self?.dataProvider
                //                                .Store(value: self.store.id)
                //                                .Brand(value: options.item.id)
                //                                .deleteObject(completion: { (err) in
                //                                    if let err = err { fatalError(err.localizedDescription) }
                //                                })
                //                        }
            })
            }.modifiedData { [unowned self] (brands) in //Data modified
                self.store.modifyBrands(brands)
                self.tableDirector.modify(cellType: BrandCellView.self, items: brands, inSection: 0)
            }.removedData { [unowned self] (brands) in //Remove data
                self.store.removeBrands(brands)
                self.tableDirector.remove(items: brands, inSection: 0, withUpdate: .left)
            }.listen()
    }
}

extension BrandsListController: BrandsListControllerInterface {
    func didSelectRow(forBrand brand: BrandEntity) {
        <#code#>
    }
    
    func didSelectRowForNews() {
        <#code#>
    }
    
    func didSelectRowForStatistics() {
        <#code#>
    }
    
    
}
