//
//  DataProvider3.swift
//  Stores
//
//  Created by ssion on 11/3/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import Foundation

struct DataProvider<EntityModelType: DocumentSerializableProtocol> {
    
    private let dataBaseAPI: GetDataAPI & OrderingDataAPI
    private let actionForNewData: (([EntityModelType]) -> ())?
    private let actionForModifiedData: (([EntityModelType]) -> ())?
    private let actionForRemovedData: (([EntityModelType]) -> ())?
    
    init(dataBaseAPI: GetDataAPI & OrderingDataAPI,
         actionForNewData: (([EntityModelType]) -> ())?,
         actionForModifiedData: (([EntityModelType]) -> ())?,
         actionForRemovedData: (([EntityModelType]) -> ())?) {
        
        self.dataBaseAPI = dataBaseAPI
        self.actionForNewData = actionForNewData
        self.actionForModifiedData = actionForModifiedData
        self.actionForRemovedData = actionForRemovedData
    }
    
    init(dataBaseAPI: GetDataAPI & OrderingDataAPI) {
        self.init(dataBaseAPI: dataBaseAPI,
                  actionForNewData: nil,
                  actionForModifiedData: nil,
                  actionForRemovedData: nil)
    }
}

extension DataProvider {
    
    func newData(completion: @escaping ([EntityModelType]) -> ()) -> DataProvider {
        return DataProvider<EntityModelType>.init(dataBaseAPI: self.dataBaseAPI,
                                 actionForNewData: completion,
                                 actionForModifiedData: self.actionForModifiedData,
                                 actionForRemovedData: self.actionForRemovedData)
    }
    
    func modifiedData(completion: @escaping ([EntityModelType]) -> ()) -> DataProvider {
        return DataProvider<EntityModelType>.init(dataBaseAPI: self.dataBaseAPI,
                                 actionForNewData: self.actionForNewData,
                                 actionForModifiedData: completion,
                                 actionForRemovedData: self.actionForRemovedData)
    }
    
    func removedData(completion: @escaping ([EntityModelType]) -> ()) -> DataProvider {
        return DataProvider<EntityModelType>.init(dataBaseAPI: self.dataBaseAPI,
                                 actionForNewData: self.actionForNewData,
                                 actionForModifiedData: self.actionForModifiedData,
                                 actionForRemovedData: completion)
    }
    
    func listen() {
        dataBaseAPI.listen { (rawData) in
            if (self.actionForNewData != nil && rawData.new.count > 0) {
                let models: [EntityModelType] = rawData.new.map{
                    guard let model = EntityModelType.init(dictionary: $0) else { fatalError($0.description) }
                    return model
                }
                self.actionForNewData!(models)
            }
            
            if (self.actionForModifiedData != nil && rawData.modified.count > 0) {
                let models: [EntityModelType] = rawData.modified.map{
                    guard let model = EntityModelType.init(dictionary: $0) else { fatalError() }
                    return model
                }
                self.actionForModifiedData!(models)
            }
            
            if (self.actionForRemovedData != nil && rawData.removed.count > 0) {
                let models: [EntityModelType] = rawData.removed.map{
                    guard let model = EntityModelType.init(dictionary: $0) else { fatalError() }
                    return model
                }
                self.actionForRemovedData!(models)
            }
        }
    }
}

//extension DataProvider {
//
//    func setObject(model: EntityModelType, completion: @escaping (Error?) -> Void) {
//        dataBaseAPI.setObject(dictionary: model.dictionary) { (err) in
//            completion(err)
//        }
//        entityPath = EntityPath()
//    }
//
//    func addObject(model: EntityModelType, completion: @escaping (Error?) -> Void) {
//        dataBaseAPI.addObject(dictionary: model.dictionary) { (err) in
//            completion(err)
//        }
//        entityPath = EntityPath()
//    }
//
//    func updateObject(model: EntityModelType, completion: @escaping (Error?) -> Void) {
//        dataBaseAPI.updateObject(dictionary: model.dictionary) { (err) in
//            completion(err)
//        }
//        entityPath = EntityPath()
//    }
//
//    func deleteObject(completion: @escaping (Error?) -> Void) {
//        dataBaseAPI.deleteObject() { (err) in
//            completion(err)
//        }
//        entityPath = EntityPath()
//    }
//}

extension DataProvider {
    
    func filter(field: String, isEqualTo value: Any) -> DataProvider {
        let newDataBaseAPI = self.dataBaseAPI.filter(field: field, isEqualTo: value)
        return DataProvider<EntityModelType>.init(dataBaseAPI: newDataBaseAPI,
                                                  actionForNewData: self.actionForNewData,
                                                  actionForModifiedData: self.actionForModifiedData,
                                                  actionForRemovedData: self.actionForRemovedData)
    }
    
    func filter(field: String, isLessThan value: Any) -> DataProvider {
        let newDataBaseAPI = self.dataBaseAPI.filter(field: field, isLessThan: value)
        return DataProvider<EntityModelType>.init(dataBaseAPI: newDataBaseAPI,
                                                  actionForNewData: self.actionForNewData,
                                                  actionForModifiedData: self.actionForModifiedData,
                                                  actionForRemovedData: self.actionForRemovedData)

    }
    
    func filter(field: String, isLessThanOrEqualTo value: Any) -> DataProvider {
        let newDataBaseAPI = self.dataBaseAPI.filter(field: field, isLessThanOrEqualTo: value)
        return DataProvider<EntityModelType>.init(dataBaseAPI: newDataBaseAPI,
                                                  actionForNewData: self.actionForNewData,
                                                  actionForModifiedData: self.actionForModifiedData,
                                                  actionForRemovedData: self.actionForRemovedData)
    }
    
    func filter(field: String, isGreaterThan value: Any) -> DataProvider {
        let newDataBaseAPI = self.dataBaseAPI.filter(field: field, isGreaterThan: value)
        return DataProvider<EntityModelType>.init(dataBaseAPI: newDataBaseAPI,
                                                  actionForNewData: self.actionForNewData,
                                                  actionForModifiedData: self.actionForModifiedData,
                                                  actionForRemovedData: self.actionForRemovedData)
    }
    
    func filter(field: String, isGreaterThanOrEqualTo value: Any) -> DataProvider {
        let newDataBaseAPI = self.dataBaseAPI.filter(field: field, isGreaterThanOrEqualTo: value)
        return DataProvider<EntityModelType>.init(dataBaseAPI: newDataBaseAPI,
                                                  actionForNewData: self.actionForNewData,
                                                  actionForModifiedData: self.actionForModifiedData,
                                                  actionForRemovedData: self.actionForRemovedData)
    }
    
    func order(by: String) -> DataProvider {
        let newDataBaseAPI = self.dataBaseAPI.order(by: by)
        return DataProvider<EntityModelType>.init(dataBaseAPI: newDataBaseAPI,
                                                  actionForNewData: self.actionForNewData,
                                                  actionForModifiedData: self.actionForModifiedData,
                                                  actionForRemovedData: self.actionForRemovedData)
    }
}
