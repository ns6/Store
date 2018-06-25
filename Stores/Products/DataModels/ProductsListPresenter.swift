//
//  ProductsListPresenter.swift
//  Stores
//
//  Created by ssion on 3/4/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

class ProductsListPresenter: DocumentIdentifiable {
    
    let product: ProductEntity
    let id: String
    var indexRow: UInt { return product.indexRow }
    let name: String
    let sold: String
    let sizes: [Size]
    var soldSizes: [Size]!
    var instock: String!
    
    init(product: ProductEntity) {
        self.product = product
        self.id = product.id
        //self.indexRow = product.indexRow
        self.name = product.itemName
        self.sold = String(product.sold.count)
        self.sizes = product.sizes
        self.soldSizes = getSoldSizes()
        self.instock = String(getInstock())
    }
    
    private func getInstock() -> Int {
        return self.sizes.reduce(0, { (count, size) -> Int in
            return count + size.count
        })
    }
    
    private func getSoldSizes() -> [Size] {
        var dictionary: [String: Int] = [:]
        self.product.sold.forEach{
            if dictionary[$0.size] == nil {
                dictionary[$0.size] = 1
            } else {
                dictionary[$0.size]! += 1
            }
        }
        return Size.createFrom(dictionary: dictionary)
    }
}
