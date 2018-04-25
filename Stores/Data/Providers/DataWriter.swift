//
//  DataWriter.swift
//  Stores
//
//  Created by ssion on 10/6/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import Foundation
import FirebaseFirestore

class DataWriter {
    
    static func setObject(documentRef: DocumentReference, dictionary: [String: Any]) {
        documentRef.setData(dictionary) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    static func addObject(collectionRef: CollectionReference, dictionary: [String: Any]) {
        collectionRef.addDocument(data: dictionary) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added")
            }
        }
    }
    
    static func updateObject(documentRef: DocumentReference, dictionary: [String: Any]) {
        documentRef.updateData(dictionary, completion: { (err) in
            if let err = err {
                print("Error update document: \(err)")
            } else {
                print("Document update")
            }
        })
            
    }
    
    static func deleteObject(documentRef: DocumentReference) {
        documentRef.delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
}
