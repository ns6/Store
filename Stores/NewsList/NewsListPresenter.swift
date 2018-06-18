//
//  NewsListPresenter.swift
//  Stores
//
//  Created by ssion on 5/8/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

//
//  MenuListVCOptions.swift
//  Stores
//
//  Created by ssion on 6/17/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol NewsListPresenterProtocol {
    var empty: Storyboardable { get }
    var normal: NewsListViewInterface { get }
}
class NewsListPresenter: NewsListPresenterProtocol {
    
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
    
    var normal: NewsListViewInterface {
        guard let current = actual as? NewsListViewController else {
            let current = NewsListViewController.storyboardViewController()
            actual = current
            present(vc: current, animated: true)
            return current
        }
        return current
    }
    
    private func present(vc: UIViewController, animated: Bool = false) {
        //RootController.shareInstance?.setFrontViewPosition(.right, animated: animated)
        //RootController.shareInstance?.setRear(menuListViewController, animated: animated)
        RootController.shareInstance?.setFront(vc, animated: animated)
    }
}

