//
//  EntityPath.swift
//  Stores
//
//  Created by ssion on 11/3/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import Foundation

struct EntityPath {
    
    private let name: [String]
    private let value: [String]
    
    var count: Int {
        return name.count
    }
    
    init(name: [String], value: [String]) {
        self.name = name
        self.value = value
    }
    
    init() {
        self.name = []
        self.value = []
    }
    
    func addPath(name: String, value: String) -> EntityPath {
        return EntityPath(name: self.name + [name], value: self.value + [value])
    }
    
    func getPath(index: Int) -> (name: String, value: String) {
        return (name[index], value[index])
    }
    
    func getPath(forEach: (String, String) -> ()) {
        for index in 0..<count {
            forEach(name[index], value[index])
        }
    }
}

extension EntityPath {
    
    func Store(value: String = "") -> EntityPath {
        return addPath(name: "Stores", value: value)
    }
    
    func Brand(value: String = "") -> EntityPath {
        return addPath(name: "Brands", value: value)
    }
    
    func SizesTypes(value: String = "") -> EntityPath {
        return addPath(name: "SizesTypes", value: value)
    }
    
    func Product(value: String = "") -> EntityPath {
        return addPath(name: "Products", value: value)
    }
}
