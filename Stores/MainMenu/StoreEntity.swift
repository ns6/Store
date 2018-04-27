//
//  Store.swift
//  Stores
//
//  Created by ssion on 10/5/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import Foundation

struct StoreEntity: DocumentIdentifiable {

    let name: String
    let count: Int
    
    //DocumentIdentifiable:
    let id: String
    let indexRow: UInt
}

extension StoreEntity: DocumentSerializableProtocol {
    init?(dictionary: [String : Any]) {
        guard let id = dictionary["id"] as? String else { return nil }
        guard let indexRow = dictionary["indexRow"] as? UInt else { return nil }
        guard let name = dictionary["name"] as? String else { return nil }
        guard let count = dictionary["count"] as? Int else { return nil }
        
        self.init(name: name, count: count, id: id, indexRow: indexRow)
    }
    
    var dictionary: [String: Any] {
        return [
            "name": name,
            "count": count
        ]
    }
}
