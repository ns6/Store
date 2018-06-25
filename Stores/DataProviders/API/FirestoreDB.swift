//
//  Firestore.swift
//  Stores
//
//  Created by ssion on 11/3/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import Foundation

import FirebaseFirestore

struct FirestoreDB {
    
    private func getCollectionRef(_ entityPath: String) -> Query? {
        let count = entityPath.split(separator: "/").filter {$0.count>0}.count
        if count % 2 != 0 {
            return Firestore.firestore().collection(entityPath)
        }
        return nil
    }
    
    private func getDocumentRef(_ entityPath: String) -> DocumentReference? {
        let count = entityPath.split(separator: "/").filter {$0.count>0}.count
        if count % 2 == 0 {
            return Firestore.firestore().document(entityPath)
        }
        return nil
    }
    
    private func parseEntityPath(_ path: EntityPath) -> String {
        var stringPath = ""
        path.getPath { (name, value) in
            //"Stores/\(store.id)/Brands/\(brand.id)/Products"
            stringPath += "/" + name + "/" + value
        }
        return stringPath
    }
    
    private func setFilters(_ filters: Filter, to collectionRef: Query) -> Query {
        var newCollectionRef = collectionRef
        
        if let filters = filters.isEqualTo {
            filters.forEach {
                newCollectionRef = newCollectionRef.whereField($0.field, isEqualTo: $0.value)
            }
        }
        
        if let filters = filters.isGreaterThan {
            filters.forEach {
                newCollectionRef = newCollectionRef.whereField($0.field, isGreaterThan: $0.value)
            }
        }
        
        if let filters = filters.isGreaterThanOrEqualTo {
            filters.forEach {
                newCollectionRef = newCollectionRef.whereField($0.field, isGreaterThanOrEqualTo: $0.value)
            }
        }
        
        if let filters = filters.isLessThan {
            filters.forEach {
                newCollectionRef = newCollectionRef.whereField($0.field, isLessThan: $0.value)
            }
        }
        
        if let filters = filters.isLessThanOrEqualTo {
            filters.forEach {
                newCollectionRef = newCollectionRef.whereField($0.field, isLessThanOrEqualTo: $0.value)
            }
        }
        
        return newCollectionRef
    }
    
    private func setOrder(order: Order, to collectionRef: Query) -> Query {
        var newCollectionRef: Query = collectionRef
        order.orderBy.forEach {
            if let descending = order.descending {
                newCollectionRef = newCollectionRef.order(by: $0, descending: descending)
            } else {
                newCollectionRef = newCollectionRef.order(by: $0)
            }
        }
        return newCollectionRef
    }
    
    private func listenDocument(ref: DocumentReference, completion: @escaping ([String : Any]) -> ()) {
        ref.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshot results: \(error!)")
                return
            }
            var data: [String:Any] = snapshot.data()!
            data["id"] = snapshot.documentID
            data["indexRow"] = UInt(0)
            completion(data)
        }
    }
        
    private func listenCollection(query: Query,
                        filters: Filter? = nil,
                        order: Order? = nil,
                        completion: @escaping (RawData) -> ()) {
        var ref = query
        if let filters = filters {
            ref = setFilters(filters, to: ref)
        }
        
        if let order = order {
            ref = setOrder(order: order, to: ref)
        }
        
        ref.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshot results: \(error!)")
                return
            }
            
            var new: [[String : Any]] = []
            var modified: [[String : Any]] = []
            var removed: [[String : Any]] = []
            
            snapshot.documentChanges.forEach{ doc in
                var tempDictionary: [String:Any] = doc.document.data()
                tempDictionary["id"] = doc.document.documentID
                tempDictionary["indexRow"] = doc.newIndex
                
                switch doc.type {
                case .added: new.append(tempDictionary)
                case .modified: modified.append(tempDictionary)
                case .removed: tempDictionary["indexRow"] = doc.oldIndex; removed.append(tempDictionary)
                }
            }
            completion(RawData.init(new: new, modified: modified, removed: removed))
        }
    }
}

extension FirestoreDB: GetDataAPI {
    
    func listen(entityPath: EntityPath,
                filters: Filter? = nil,
                order: Order? = nil,
                completion: @escaping (RawData) -> ()) {
        
        let parsedEntityPath = parseEntityPath(entityPath)
        if let collectionRef = getCollectionRef(parsedEntityPath) {
            listenCollection(query: collectionRef, filters: filters, order: order, completion: completion)
        } else if let documentRef = getDocumentRef(parsedEntityPath) {
            listenDocument(ref: documentRef) { (data) in
                let rawData = RawData(new: [data], modified: [], removed: [])
                completion(rawData)
            }
        }
    }
}

//extension FirestoreDB: PostDataAPI {
//
//    func setObject(entityPath: String, dictionary: [String : Any], completion: @escaping (Error?) -> Void) {
//        let documentRef = Firestore.firestore().document(entityPath)
//        documentRef.setData(dictionary) { err in
//            if let err = err {
//                completion(err)
//            } else {
//                completion(nil)
//            }
//        }
//    }
//
//    func addObject(entityPath: String, dictionary: [String : Any], completion: @escaping (Error?) -> Void) {
//        let collectionRef = Firestore.firestore().collection(entityPath)
//        collectionRef.addDocument(data: dictionary) { err in
//            if let err = err {
//                completion(err)
//            } else {
//                completion(nil)
//            }
//        }
//    }
//
//    func updateObject(entityPath: String, dictionary: [String : Any], completion: @escaping (Error?) -> Void) {
//        let documentRef = Firestore.firestore().document(entityPath)
//        documentRef.updateData(dictionary, completion: { (err) in
//            if let err = err {
//                completion(err)
//            } else {
//                completion(nil)
//            }
//        })
//    }
//
//    func deleteObject(entityPath: String, completion: @escaping (Error?) -> Void) {
//        let documentRef = Firestore.firestore().document(entityPath)
//        documentRef.delete() { err in
//            if let err = err {
//                completion(err)
//            } else {
//                completion(nil)
//            }
//        }
//    }
//}
