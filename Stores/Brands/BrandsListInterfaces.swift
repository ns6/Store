//
//  BrandsListInterfaces.swift
//  Stores
//
//  Created by ssion on 4/29/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol BrandsListViewInterface: Storyboardable {
    var didLoadBlock: ((_ sender: BrandsListViewInterface)->())? {get set}
    func newData(entity: [BrandEntity])
    func modifiedData(entity: [BrandEntity])
    func removedData(entity: [BrandEntity])
}

protocol BrandsListControllerInterface {
    mutating func viewDidLoad()
    mutating func viewDidDisappear()
    mutating func didSelectRow(forBrand brand: BrandEntity)
}

