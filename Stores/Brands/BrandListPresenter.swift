//
//  BrandListPresenter.swift
//  Stores
//
//  Created by ssion on 5/4/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol BrandListPresenterInterface {
    init()
    init(emptyState: EmptyStateViewControllerInterface, normalState: BrandsListViewInterface)
    func newData(_ brands: [BrandEntity])
    func modifiedData(_ brands: [BrandEntity])
    func removedData(_ brands: [BrandEntity])
}

class BrandListPresenter: BrandListPresenterInterface {

    private var viewDidLoad: Bool = false
    private lazy var emptyState: EmptyStateViewControllerInterface = EmptyStateViewController.storyboardViewController()
    private lazy var normalState: BrandsListViewInterface = BrandsListViewController.storyboardViewController()
    
    required init() {
        self.present(viewController: emptyState as! UIViewController)
    }

    required init(emptyState: EmptyStateViewControllerInterface, normalState: BrandsListViewInterface) {
        self.emptyState = emptyState
        self.normalState = normalState
        self.present(viewController: emptyState as! UIViewController)
    }
    
    private func present(viewController: UIViewController, animated: Bool = true) {
        let navController = UINavigationController(rootViewController: viewController)
        RootController.shareInstance?.setFrontViewPosition(FrontViewPosition.left, animated: animated)
        RootController.shareInstance?.pushFrontViewController(navController, animated: animated)
    }
    
    func newData(_ brands: [BrandEntity]) {
        if self.viewDidLoad == false {
            self.normalState.didLoadBlock =  {[weak self] (this) -> Void  in
                self?.viewDidLoad = true
                this.newData(entity: brands)
            }
            present(viewController: normalState as! UIViewController, animated: false)
        } else {
            self.normalState.newData(entity: brands)
        }
    }
    
    func modifiedData(_ brands: [BrandEntity]) {
        self.normalState.modifiedData(entity: brands)
    }
    
    func removedData(_ brands: [BrandEntity]) {
        self.normalState.removedData(entity: brands)
    }
}
