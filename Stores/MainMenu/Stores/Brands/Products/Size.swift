//
//  Size.swift
//  Stores
//
//  Created by ssion on 1/14/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

struct Size {
    
    var size: String
    var count: Int
    
    var dictionary: [String: Any] {
        return [size : count]
    }
    
    static func createFrom(dictionary: [String : Any]) -> [Size] {
        return dictionary.map {
            guard let value = $0.value as? Int else {fatalError()}
            return Size(size: $0.key, count: value)
        }
    }
    
    static func convertToDictionary(_ sizes: [Size]) -> [String : Any] {
        var dictionary: [String : Any] = [:]
        sizes.forEach {
             dictionary[$0.size] = $0.count
        }
        return dictionary
    }
}
