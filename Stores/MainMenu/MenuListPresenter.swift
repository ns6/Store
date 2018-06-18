//
//  MenuListVCOptions.swift
//  Stores
//
//  Created by ssion on 6/17/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol MenuListPresenterProtocol {
    var empty: Storyboardable { get }
    var normal: MenuListViewControllerProtocol { get }
    
    var didLoad: ((_ sender: MenuListViewControllerProtocol)->())? {get set}
    var didDisappear: ((_ sender: MenuListViewControllerProtocol)->())? {get set}
    var didSelectStore: ((_ brand: StoreEntity)->())? {get set}
}

class MenuListPresenter: MenuListPresenterProtocol {
    
    private var actual: Any? = nil
    
    var empty: Storyboardable {
        guard let current = actual as? EmptyStateViewController else {
            let current = EmptyStateViewController.storyboardViewController()
            actual = current
            present(vc: current, animated: true)
            return current
        }
        return current
    }
    
    var normal: MenuListViewControllerProtocol {
        guard let current = actual as? MenuListViewController else {
            let current = MenuListViewController.storyboardViewController()
            
            //set callBack
            current.didLoad = self.didLoad
            current.didDisappear = self.didDisappear
            current.didSelectStore = self.didSelectStore
            
            actual = current
            present(vc: current, animated: true)
            return current
        }
        return current
    }
    
    var didLoad: ((_ sender: MenuListViewControllerProtocol)->())?
    var didDisappear: ((_ sender: MenuListViewControllerProtocol)->())?
    var didSelectStore: ((_ brand: StoreEntity)->())?
    
    private func present(vc: UIViewController, animated: Bool = false) {
        //RootController.shareInstance?.setFrontViewPosition(.right, animated: animated)
        RootController.shareInstance?.setRear(vc, animated: animated)
    }
}
