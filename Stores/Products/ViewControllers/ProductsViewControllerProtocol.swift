//
//  ProductsViewControllerProtocol.swift
//  Stores
//
//  Created by ssion on 6/17/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol ProductsViewControllerProtocol: Storyboardable {
    func newData(entity: [ProductEntity])
    func modifiedData(entity: [ProductEntity])
    func removedData(entity: [ProductEntity])
    
    var didLoad: ((_ sender: ProductsViewControllerProtocol)->())? {get set}
    var didDisappear: ((_ sender: ProductsViewControllerProtocol)->())? {get set}
    var didSelectProduct: ((_ product: ProductEntity)->())? {get set}
}
