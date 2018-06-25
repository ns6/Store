//
//  ProductDetailsPresenter.swift
//  Stores
//
//  Created by ssion on 6/19/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol ProductDetailsPresenterProtocol {
    var empty: Storyboardable { get }
    var normal: ProductDetailsViewControllerProtocol { get }
    
    var didLoad: ((_ sender: ProductDetailsViewControllerProtocol)->())? {get set}
    var didDisappear: ((_ sender: ProductDetailsViewControllerProtocol)->())? {get set}
    var didSelectBrand: ((_ product: ProductEntity)->())? {get set}
}

class ProductDetailsPresenter: ProductDetailsPresenterProtocol {
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
    
    var normal: ProductDetailsViewControllerProtocol {
        guard let current = actual as? ProductDetailsViewController else {
            let current = ProductDetailsViewController.storyboardViewController()
            
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
    
    var didLoad: ((_ sender: ProductDetailsViewControllerProtocol)->())?
    var didDisappear: ((_ sender: ProductDetailsViewControllerProtocol)->())?
    var didSelectBrand: ((_ product: ProductEntity)->())?
    
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
