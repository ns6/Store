//
//  ProductDetailsViewControllerProtocol.swift
//  Stores
//
//  Created by ssion on 6/19/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol ProductDetailsViewControllerProtocol: Storyboardable {
    func newData(entity: ProductEntity)
    
    var didLoad: ((_ sender: ProductDetailsViewControllerProtocol)->())? {get set}
    var didDisappear: ((_ sender: ProductDetailsViewControllerProtocol)->())? {get set}
    var didSelectBrand: ((_ product: ProductEntity)->())? {get set}
}
