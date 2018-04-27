//
//  Product.swift
//  Stores
//
//  Created by ssion on 9/28/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import Foundation


struct ProductEntity: DocumentIdentifiable {
    
//    weak var brand: Brand? {
//        didSet {
//            guard let sizesTypes = brand?.store?.sizes else {fatalError()}
//            guard let sortedSizes = (sizesTypes.filter{$0.id == sizesType}.first?.sizes) else {fatalError()}
//            self.sizes = self.sizes.sorted {
//                let firstIndex = sortedSizes.index(of: $0.size)!
//                let secondIndex = sortedSizes.index(of: $1.size)!
//                return firstIndex < secondIndex
//            }
//        }
//    }
    
    let itemName: String
    let sex: String
    let color: String
    let purchasePrice: Int
    let sellPrice: Double
    let timeAdded: Date
    let comment: String
    let isDeleted: Bool
    let sizesType: String
    let sizes: [Size]
    let sold: [Sold]
    
    //DocumentIdentifiable
    let id: String
    let indexRow: UInt
}

extension ProductEntity: DocumentSerializableProtocol {
    init?(dictionary: [String : Any]) {
        guard let id = dictionary["id"] as? String,
            let indexRow = dictionary["indexRow"] as? UInt,
            let itemName = dictionary["itemName"] as? String,
            let sex = dictionary["sex"] as? String,
            let color = dictionary["color"] as? String,
            let purchasePrice = dictionary["purchasePrice"] as? Int,
            let sellPrice = dictionary["sellPrice"] as? Double,
            let timeAdded = dictionary["timeAdded"] as? Date,
            let comment = dictionary["comment"] as? String,
            let isDeleted = dictionary["isDeleted"] as? Bool,
            let sizesType = dictionary["sizesType"] as? String,
            let sizes = dictionary["sizes"] as? [String: Int],
            let sold = dictionary["sold"] as? [[String: Any]] else { return nil }
        
        self.init(itemName: itemName,
                  sex: sex,
                  color: color,
                  purchasePrice: purchasePrice,
                  sellPrice: sellPrice,
                  timeAdded: timeAdded,
                  comment: comment,
                  isDeleted: isDeleted,
                  sizesType: sizesType,
                  sizes: Size.createFrom(dictionary: sizes),
                  sold: Sold.createFrom(collection: sold),
                  id: id,
                  indexRow: indexRow)
    }
    
    var dictionary: [String: Any] {
        return [
            "itemName": itemName,
            "sex": sex,
            "color": color,
            "purchasePrice": purchasePrice,
            "sellPrice": sellPrice,
            "timeAdded": timeAdded,
            "comment": comment,
            "isDeleted": isDeleted,
            "sizesType": sizesType,
            "sizes": Size.convertToDictionary(sizes),
            "sold": Sold.convertToDictionary(sold)
        ]
    }
}
