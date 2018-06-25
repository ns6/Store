//
//  DPFunctionality.swift
//  Stores
//
//  Created by ssion on 6/15/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol DPFunctionality {
    func listen<EntityModelType: DocumentSerializableProtocol>(
                db: GetDataAPI,
                entityPath: EntityPath,
                filters: Filter?,
                order: Order?,
                newData: (([EntityModelType]) -> Void)?,
                modifiedData: (([EntityModelType]) -> Void)?,
                removedData: (([EntityModelType]) -> Void)?)
}

extension DPFunctionality {
    func listen<EntityModelType: DocumentSerializableProtocol>(
        db: GetDataAPI,
        entityPath: EntityPath,
        filters: Filter?,
        order: Order?,
        newData: (([EntityModelType]) -> Void)? = nil,
        modifiedData: (([EntityModelType]) -> Void)? = nil,
        removedData: (([EntityModelType]) -> Void)? = nil) {
        
        db.listen(entityPath: entityPath, filters: filters, order: order) { (rawData) in
            if let newData = newData, rawData.new.count > 0 {
                let models: [EntityModelType] = rawData.new.map {
                    guard let model = EntityModelType.init(dictionary: $0) else {
                        fatalError($0.description)
                        
                    }
                    return model
                }
                newData(models)
            }
            
            if let modifiedData = modifiedData, rawData.modified.count > 0 {
                let models: [EntityModelType] = rawData.modified.map{
                    guard let model = EntityModelType.init(dictionary: $0) else { fatalError($0.description) }
                    return model
                }
                modifiedData(models)
            }
            
            if let removedData = removedData, rawData.removed.count > 0 {
                let models: [EntityModelType] = rawData.removed.map{
                    guard let model = EntityModelType.init(dictionary: $0) else { fatalError($0.description) }
                    return model
                }
                removedData(models)
            }
        }
    }
}
