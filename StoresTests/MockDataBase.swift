//
//  MockDataBase.swift
//  StoresTests
//
//  Created by ssion on 4/12/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

@testable import Stores

class MockDataBase: RetrieveWriteDataAPI {
    
    var rawData: RawData
    
    init(new: [[String : Any]], modified: [[String : Any]], removed: [[String : Any]]) {
        rawData = RawData(new: new, modified: modified, removed: removed)
    }
    
    convenience init(new: [[String : Any]]) {
        self.init(new: new, modified: [], removed: [])
    }
    
    convenience init(modified: [[String : Any]]) {
        self.init(new: [], modified: modified, removed: [])
    }
    
    convenience init(removed: [[String : Any]]) {
        self.init(new: [], modified: [], removed: removed)
    }
    
    convenience init() {
        self.init(new: [], modified: [], removed: [])
    }
    
    convenience init(rawData: RawData) {
        self.init()
        self.rawData = rawData
    }
    
    func entityPath(_ path: EntityPath) -> Self {
        return self
    }
    
    func listen(completion: @escaping (RawData) -> Void) {
        completion(self.rawData)
    }
    
    func stopListening() {
        
    }
    
    func filter(field: String, isEqualTo: Any) -> Self {
        return self
    }
    
    func filter(field: String, isLessThan: Any) -> Self {
        return self
    }
    
    func filter(field: String, isLessThanOrEqualTo: Any) -> Self {
        return self
    }
    
    func filter(field: String, isGreaterThan: Any) -> Self {
        return self
    }
    
    func filter(field: String, isGreaterThanOrEqualTo: Any) -> Self {
        return self
    }
    
    func order(by: String) -> Self {
        return self
    }
    
    func setObject(dictionary: [String : Any], completion: @escaping (Error?) -> Void) {
        
    }
    
    func addObject(dictionary: [String : Any], completion: @escaping (Error?) -> Void) {
        
    }
    
    func updateObject(dictionary: [String : Any], completion: @escaping (Error?) -> Void) {
        
    }
    
    func deleteObject(completion: @escaping (Error?) -> Void) {
        
    }
    
    
}
