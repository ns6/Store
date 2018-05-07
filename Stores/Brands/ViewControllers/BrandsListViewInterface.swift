//
//  BrandsListInterfaces.swift
//  Stores
//
//  Created by ssion on 4/29/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol BrandsListViewInterface: Storyboardable {
    var didLoadBlock: ((_ sender: BrandsListViewInterface)->())? {get set}
    var didDisappearBlock: ((_ sender: BrandsListViewInterface)->())? {get set}
    var didSelectBrandBlock: ((_ brand: BrandEntity)->())? {get set}
    
    func newData(entity: [BrandEntity])
    func modifiedData(entity: [BrandEntity])
    func removedData(entity: [BrandEntity])
}
