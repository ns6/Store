//
//  VCFactory.swift
//  Stores
//
//  Created by ssion on 6/16/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol VCFactoryProtocol {
    func getViewController<VCType: UIViewController>() -> VCType where VCType: Storyboardable
}

struct VCFactory: VCFactoryProtocol {
    func getViewController<VCType: UIViewController>() -> VCType where VCType: Storyboardable {
        return VCType.storyboardViewController()
    }
}
