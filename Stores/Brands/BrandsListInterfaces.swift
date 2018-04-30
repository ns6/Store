//
//  BrandsListInterfaces.swift
//  Stores
//
//  Created by ssion on 4/29/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol BrandsListViewInterface: Storyboardable {
    func setController(controller: BrandsListControllerInterface) -> Bool
    func newData(entity: [BrandEntity])
    func modifiedData(entity: [BrandEntity])
    func removedData(entity: [BrandEntity])
}

protocol BrandsListControllerInterface {
    func didSelectRow(forBrand brand: BrandEntity)
    func didSelectRowForNews()
    func didSelectRowForStatistics()
}

protocol BrandsListSegueInterface {
    func segueToBrandsList(forStore store: StoreEntity)
}

