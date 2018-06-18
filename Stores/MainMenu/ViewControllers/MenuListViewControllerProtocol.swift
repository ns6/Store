//
//  MenuListInterfaces.swift
//  Stores
//
//  Created by ssion on 4/28/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol MenuListViewControllerProtocol: Storyboardable {
    func newData(entity: [StoreEntity])
    func modifiedData(entity: [StoreEntity])
    func removedData(entity: [StoreEntity])
    
    var didLoad: ((_ sender: MenuListViewControllerProtocol)->())? {get set}
    var didDisappear: ((_ sender: MenuListViewControllerProtocol)->())? {get set}
    var didSelectStore: ((_ brand: StoreEntity)->())? {get set}
}

