//
//  DataProviderProtocol.swift
//  Stores
//
//  Created by ssion on 11/2/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol GetDataAPI {
    func listen(completion: @escaping (RawData) -> Void)
}

protocol OrderingDataAPI {
    func filter(field: String, isEqualTo: Any) -> Self
    func filter(field: String, isLessThan: Any) -> Self
    func filter(field: String, isLessThanOrEqualTo: Any) -> Self
    func filter(field: String, isGreaterThan: Any) -> Self
    func filter(field: String, isGreaterThanOrEqualTo: Any) -> Self
    func order(by: String) -> Self
}

protocol PostDataAPI {
    func setObject(dictionary: [String: Any], completion: @escaping (Error?) -> Void)
    func addObject(dictionary: [String: Any], completion: @escaping (Error?) -> Void)
    func updateObject(dictionary: [String: Any], completion: @escaping (Error?) -> Void)
    func deleteObject(completion: @escaping (Error?) -> Void)
}

public protocol DocumentSerializableProtocol {
    init?(dictionary: [String: Any])
    var dictionary: [String: Any] {get}
}

public protocol DocumentIdentifiable {
    var id: String {get}
    var indexRow: UInt {get}
}

//public protocol DocumentSerializableAndIdentifiable: DocumentSerializableProtocol, DocumentIdentifiable {}

