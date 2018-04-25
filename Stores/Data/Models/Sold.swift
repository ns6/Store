//
//  Sold.swift
//  Stores
//
//  Created by ssion on 9/28/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import Foundation

struct Sold {
    
    var time: Date
    var size: String
    var price: Double

    static func createFrom(collection: [[String : Any]]) -> [Sold] {
        return collection.map{ Sold(dictionary: $0) }
    }
    
    static func convertToDictionary(_ sold: [Sold]) -> [[String : Any]] {
        return sold.map{ $0.dictionary }
    }
}

extension Sold: DocumentSerializableProtocol {
    init(dictionary: [String : Any]) {
        guard let time = dictionary["time"] as? Date else { fatalError() }
        guard    let size = dictionary["size"] as? String else { fatalError() }
        guard    let price = dictionary["price"] as? Double else { fatalError() }
        
        self.init(time: time, size: size, price: price)
    }
    
    var dictionary: [String: Any] {
        return [
            "time": time.description,
            "size": size,
            "price": price
        ]
    }
}
