//
//  BrandsListInterfaces.swift
//  Stores
//
//  Created by ssion on 4/29/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol BrandsViewControllerProtocol: Storyboardable {
    func newData(entity: [BrandEntity])
    func modifiedData(entity: [BrandEntity])
    func removedData(entity: [BrandEntity])
    
    var didLoad: ((_ sender: BrandsViewControllerProtocol)->())? {get set}
    var didDisappear: ((_ sender: BrandsViewControllerProtocol)->())? {get set}
    var didSelectBrand: ((_ brand: BrandEntity)->())? {get set}
}
