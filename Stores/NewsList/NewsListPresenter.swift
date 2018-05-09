//
//  NewsListPresenter.swift
//  Stores
//
//  Created by ssion on 5/8/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol NewsListPresenterInterface {
    init()
    init(normalState: NewsListViewInterface)
    func setViewOption(_: @escaping () -> NewsListViewOptions)
}

/*
protocol NewsListPresenterSendDataInterface {
    func newData(_ stores: [StoreEntity])
    func modifiedData(_ stores: [StoreEntity])
    func removedData(_ stores: [StoreEntity])
}
*/

protocol NewsListPresenterResponseInterface{
    @discardableResult
    func setViewDidLoad(_: @escaping (_ sender: NewsListViewInterface)->()) -> NewsListPresenterResponseInterface
    @discardableResult
    func setViewDidDisappear(_: @escaping (_ sender: NewsListViewInterface)->()) -> NewsListPresenterResponseInterface
}

enum NewsListViewOptions {
    case regularView
}

class NewsListPresenter: NewsListPresenterInterface {
    
    private struct ViewOptionsContainer {
        static let option1: NewsListViewInterface = NewsListViewController.storyboardViewController()
    }
    
    private var viewIsLoaded: Bool = false
    private var normalState: NewsListViewInterface
    
    // For NewsListPresenterInterface
    private var NewsListViewOptions: (() -> NewsListViewOptions)?
    
    // For NewsListPresenterResponseInterface
    private var viewDidLoad: ((_ sender: NewsListViewInterface)->())?
    private var viewDidDisappear: ((_ sender: NewsListViewInterface)->())?
    
    private func setNormalState() {
        if let block = self.NewsListViewOptions {
            switch block() {
            case .regularView:
                self.normalState = ViewOptionsContainer.option1
            }
            
        }
        // set actions for view response
        self.normalState.didLoadBlock = self.viewDidLoad
//        self.normalState.didDisappearBlock = self.viewDidDisappear
//        self.normalState.didSelectStoreBlock = self.viewDidSelectStore
    }
    
    private func present(newsListViewController: UIViewController, animated: Bool = false) {
        RootController.shareInstance?.setFront(newsListViewController, animated: animated)
        //RootController.shareInstance?.setFrontViewPosition(.right, animated: animated)
        //RootController.shareInstance?.setFrontViewPosition(.left, animated: animated)
    }
    
    //MARK: - NewsListPresenterInterface Implementation
    convenience required init() {
        self.init(normalState: ViewOptionsContainer.option1)
    }
    
    required init(normalState: NewsListViewInterface) {
        self.normalState = normalState
            
        let tmpViewDidLoadBlock = self.viewDidLoad
        self.viewDidLoad = nil
        
        self.viewDidLoad = { (this)  in
            if tmpViewDidLoadBlock != nil {
                tmpViewDidLoadBlock!(this)
            }
            RootController.shareInstance?.setFrontViewPosition(FrontViewPosition.right, animated: true)
        }
        setNormalState()
        present(newsListViewController: normalState as! UIViewController, animated: false)
    }
    
    func setViewOption(_ block: @escaping () -> NewsListViewOptions) {
        if self.NewsListViewOptions == nil {
            self.NewsListViewOptions = block
        }
    }
}
/*
//MARK: - NewsListPresenterSendDataInterface Implementation
extension NewsListPresenter: NewsListPresenterSendDataInterface {
    func newData(_ stores: [StoreEntity]) {
        if self.viewIsLoaded == false {
            
            let tmpViewDidLoadBlock = self.viewDidLoad
            self.viewDidLoad = nil
            
            self.viewDidLoad = { [weak self] (this)  in
                if tmpViewDidLoadBlock != nil {
                    tmpViewDidLoadBlock!(this)
                }
                self?.viewIsLoaded = true
                this.newData(entity: stores)
            }
            setNormalState()
            present(newsListViewController: normalState as! UIViewController, animated: false)
        } else {
            self.normalState.newData(entity: stores)
        }
    }
    
    func modifiedData(_ stores: [StoreEntity]) {
        self.normalState.modifiedData(entity: stores)
    }
    
    func removedData(_ stores: [StoreEntity]) {
        self.normalState.removedData(entity: stores)
    }
}
*/
//MARK: - NewsListPresenterResponseInterface Implementation
extension NewsListPresenter: NewsListPresenterResponseInterface {
    @discardableResult
    func setViewDidLoad(_ block: @escaping (_ sender: NewsListViewInterface) -> ()) -> NewsListPresenterResponseInterface {
        if self.viewDidLoad == nil {
            self.viewDidLoad = block
        }
        return self
    }
    
    @discardableResult
    func setViewDidDisappear(_ block: @escaping (_ sender: NewsListViewInterface) -> ()) -> NewsListPresenterResponseInterface {
        if self.viewDidDisappear == nil {
            self.viewDidDisappear = block
        }
        return self
    }
}
