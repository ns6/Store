//
//  SizesTypes.swift
//  Stores
//
//  Created by ssion on 1/21/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

struct SizesType {
    
    let id: String
    let sizes: [String]
}

//to do reworke
extension SizesType: DocumentSerializableProtocol {
    init?(dictionary: [String : Any]) {
        let sizesDictionary: [String : Any] = dictionary.filter{$0.key != "indexRow" && $0.key != "id"}
        
        let sizes: [String] = sizesDictionary.sorted {
                guard let firstValue = $0.value as? Int else {fatalError()}
                guard let secondValue = $1.value as? Int else {fatalError()}
                return firstValue < secondValue
            }.map{$0.key}
        
        guard let id = dictionary["id"] as? String else { fatalError() }
        self.init(id: id, sizes: sizes)
    }
    
    var dictionary: [String: Any] {
        var dict: [String: Any] = [:]
        self.sizes.enumerated().forEach{ dict[$0.element] = String($0.offset) }
        return dict
    }
}
