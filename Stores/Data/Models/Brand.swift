//
//  Brand.swift
//  Stores
//
//  Created by ssion on 9/30/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import Foundation

struct Brand: DocumentIdentifiable {
    
    let name: String
    let count: Int
    
    //DocumentIdentifiable:
    let id: String
    let indexRow: UInt
}

extension Brand: DocumentSerializableProtocol {
    init?(dictionary: [String : Any]) {
        guard let id = dictionary["id"] as? String,
              let indexRow = dictionary["indexRow"] as? UInt,
              let name = dictionary["name"] as? String,
              let count = dictionary["count"] as? Int else { return nil }
        
        self.init(name: name, count: count, id: id, indexRow: indexRow)
    }
    
    var dictionary: [String: Any] {
        return [
            "name": name,
            "count": count
        ]
    }
}
