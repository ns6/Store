//
//  DataProviderFactory.swift
//  Stores
//
//  Created by ssion on 11/3/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import Foundation

struct DataProviderFactory<EntityModelType: DocumentSerializableProtocol> {
    
   struct GetDataProvider {
        static func leftSideMenu() -> DataProvider<EntityModelType> {
            let path = EntityPath().Store().firestorePath()
            return DataProvider<EntityModelType>.init(dataBaseAPI: FirestoreDB(entityPath: path))
        }
    
        static func brandsList(storeId: String) -> DataProvider<EntityModelType> {
            let path = EntityPath().Store(value: storeId).Brand().firestorePath()
            return DataProvider<EntityModelType>.init(dataBaseAPI: FirestoreDB(entityPath: path))
        }
    
        static func sizesTypesList(storeId: String) -> DataProvider<EntityModelType> {
            let path = EntityPath().Store(value: storeId).SizesTypes().firestorePath()
            return DataProvider<EntityModelType>.init(dataBaseAPI: FirestoreDB(entityPath: path))
        }
    
        static func productsList(storeId: String, brandId: String) -> DataProvider<EntityModelType> {
            let path = EntityPath().Store(value: storeId).Brand(value: brandId).Product().firestorePath()
            return DataProvider<EntityModelType>.init(dataBaseAPI: FirestoreDB(entityPath: path))
        }
    }
    
}
