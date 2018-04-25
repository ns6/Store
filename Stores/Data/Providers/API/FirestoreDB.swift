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
    
    let entityRef: Query
    
    private static func makeEntityCollectionRef(_ entityPath: String) -> Query {
        let count = entityPath.split(separator: "/").filter {$0.count>0}.count
        if count % 2 != 0 {
            return Firestore.firestore().collection(entityPath)
        }
        fatalError("entityPath is wrong - \(entityPath)")
    }
    
    init(entityRef: Query) {
        self.entityRef = entityRef
    }
    
    init(entityPath: String) {
        self.init(entityRef: FirestoreDB.makeEntityCollectionRef(entityPath))
    }
}

extension FirestoreDB: GetDataAPI {
    
    func listen(completion: @escaping (RawData) -> ()) {
        self.entityRef.addSnapshotListener { querySnapshot, error in
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
    
extension FirestoreDB: OrderingDataAPI {
        
    func filter(field: String, isEqualTo value: Any) -> FirestoreDB {
        let newEntityRef = self.entityRef.whereField(field, isEqualTo: value)
        return FirestoreDB(entityRef: newEntityRef)
    }
    
    func filter(field: String, isLessThan value: Any) -> FirestoreDB {
        let newEntityRef = self.entityRef.whereField(field, isLessThan: value)
        return FirestoreDB(entityRef: newEntityRef)
    }
    
    func filter(field: String, isLessThanOrEqualTo value: Any) -> FirestoreDB {
        let newEntityRef = self.entityRef.whereField(field, isLessThanOrEqualTo: value)
        return FirestoreDB(entityRef: newEntityRef)
    }
    
    func filter(field: String, isGreaterThan value: Any) -> FirestoreDB {
        let newEntityRef = self.entityRef.whereField(field, isGreaterThan: value)
        return FirestoreDB(entityRef: newEntityRef)
    }
    
    func filter(field: String, isGreaterThanOrEqualTo value: Any) -> FirestoreDB {
        let newEntityRef = self.entityRef.whereField(field, isGreaterThanOrEqualTo: value)
        return FirestoreDB(entityRef: newEntityRef)
    }
    
    func order(by: String) -> FirestoreDB {
        let newEntityRef = self.entityRef.order(by: by)
        return FirestoreDB(entityRef: newEntityRef)
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
