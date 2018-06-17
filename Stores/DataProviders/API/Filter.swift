//
//  Filter.swift
//  Stores
//
//  Created by ssion on 6/15/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

struct Filter {
    private var filters: [String: [(field: String, value: Any)]] = [:]
    
    var isEqualTo: [(field: String, value: Any)]? {
        return filters["isEqualTo"]
    }
    var isLessThan: [(field: String, value: Any)]? {
        return filters["isLessThan"]
    }
    var isLessThanOrEqualTo: [(field: String, value: Any)]? {
        return filters["isLessThanOrEqualTo"]
    }
    var isGreaterThan: [(field: String, value: Any)]? {
        return filters["isGreaterThan"]
    }
    var isGreaterThanOrEqualTo: [(field: String, value: Any)]? {
        return filters["isGreaterThanOrEqualTo"]
    }
    
    mutating func filter(field: String, isEqualTo value: Any) -> Filter {
        filters["isEqualTo"] == nil ? filters["isEqualTo"] = [(field, value)] : filters["isEqualTo"]?.append((field, value))
        return self
    }
    
    mutating func filter(field: String, isLessThan value: Any) -> Filter {
        filters["isLessThan"] == nil ? filters["isLessThan"] = [(field, value)] : filters["isLessThan"]?.append((field, value))
        return self
    }
    
    mutating func filter(field: String, isLessThanOrEqualTo value: Any) -> Filter {
        filters["isLessThanOrEqualTo"] == nil ? filters["isLessThanOrEqualTo"] = [(field, value)] : filters["isLessThanOrEqualTo"]?.append((field, value))
        return self
    }
    
    mutating func filter(field: String, isGreaterThan value: Any) -> Filter {
        filters["isGreaterThan"] == nil ? filters["isGreaterThan"] = [(field, value)] : filters["isGreaterThan"]?.append((field, value))
        return self
    }
    
    mutating func filter(field: String, isGreaterThanOrEqualTo value: Any) -> Filter {
        filters["isGreaterThanOrEqualTo"] == nil ? filters["isGreaterThanOrEqualTo"] = [(field, value)] : filters["isGreaterThanOrEqualTo"]?.append((field, value))
        return self
    }
}
