//
//  MenuListInterfaces.swift
//  Stores
//
//  Created by ssion on 4/28/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol MenuListViewInterface: Storyboardable {
    var didLoadBlock: ((_ sender: MenuListViewInterface)->())? {get set}
    var didDisappearBlock: ((_ sender: MenuListViewInterface)->())? {get set}
    var didSelectStoreBlock: ((_ brand: StoreEntity)->())? {get set}
    
    func newData(entity: [StoreEntity])
    func modifiedData(entity: [StoreEntity])
    func removedData(entity: [StoreEntity])
}

