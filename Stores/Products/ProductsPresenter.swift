//
//  ProductPresenter.swift
//  Stores
//
//  Created by ssion on 6/17/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol ProductsPresenterProtocol {
    var empty: Storyboardable { get }
    var normal: ProductsViewControllerProtocol { get }
    
    var didLoad: ((_ sender: ProductsViewControllerProtocol)->())? {get set}
    var didDisappear: ((_ sender: ProductsViewControllerProtocol)->())? {get set}
    var didSelectBrand: ((_ brand: ProductEntity)->())? {get set}
}

class ProductsPresenter: ProductsPresenterProtocol {
    private var actual: Any? = nil
    
    var empty: Storyboardable {
        guard let current = actual as? EmptyStateViewController else {
            let current = EmptyStateViewController.storyboardViewController()
            present(vc: current, animated: true)
            actual = current
            return current
        }
        return current
    }
    
    var normal: ProductsViewControllerProtocol {
        guard let current = actual as? ProductsViewController else {
            let current = ProductsViewController.storyboardViewController()
            
            //set callBack
            current.didLoad = self.didLoad
            current.didDisappear = self.didDisappear
            current.didSelectBrand = self.didSelectBrand
            
            present(vc: current, animated: true)
            actual = current
            return current
        }
        return current
    }
    
    var didLoad: ((_ sender: ProductsViewControllerProtocol)->())?
    var didDisappear: ((_ sender: ProductsViewControllerProtocol)->())?
    var didSelectBrand: ((_ brand: ProductEntity)->())?
    
    private func present(vc: UIViewController, animated: Bool = false) {
        guard let rootController = RootController.shareInstance else { fatalError() }
        
        if let navController = rootController.frontViewController as? UINavigationController {
            if self.actual == nil {
                navController.pushViewController(vc, animated: animated)
            } else {
                navController.popViewController(animated: false)
                navController.pushViewController(vc, animated: false)
            }
        } else {
            let navController = UINavigationController(rootViewController: vc)
            rootController.setFront(navController, animated: animated)
        }
    }
}
