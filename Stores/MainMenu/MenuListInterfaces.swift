//
//  MenuListInterfaces.swift
//  Stores
//
//  Created by ssion on 4/28/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol MenuListViewInterface: Storyboardable {
    func setController(controller: MenuListControllerInterface) -> Bool
    func newData(entity: [StoreEntity])
    func modifiedData(entity: [StoreEntity])
    func removedData(entity: [StoreEntity])
}

protocol MenuListControllerInterface {
    func didSelectRow(forStore store: StoreEntity)
    func didSelectRowForNews()
    func didSelectRowForStatistics()
}
