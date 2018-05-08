//
//  MenuListPresenter.swift
//  Stores
//
//  Created by ssion on 5/7/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol MenuListPresenterInterface {
    init()
    init(normalState: MenuListViewInterface)
    func setViewOption(_: @escaping () -> MenuListViewOptions)
}

protocol MenuListPresenterSendDataInterface {
    func newData(_ stores: [StoreEntity])
    func modifiedData(_ stores: [StoreEntity])
    func removedData(_ stores: [StoreEntity])
}

protocol MenuListPresenterResponseInterface{
    @discardableResult
    func setViewDidLoad(_: @escaping (_ sender: MenuListViewInterface)->()) -> MenuListPresenterResponseInterface
    @discardableResult
    func setViewDidDisappear(_: @escaping (_ sender: MenuListViewInterface)->()) -> MenuListPresenterResponseInterface
    @discardableResult
    func setViewDidSelectStore(_: @escaping (_ store: StoreEntity)->()) -> MenuListPresenterResponseInterface
}

enum MenuListViewOptions {
    case regularView
}

class MenuListPresenter: MenuListPresenterInterface {
    
    private struct ViewOptionsContainer {
        static let option1: MenuListViewInterface = MenuListViewController.storyboardViewController()
    }
    
    private var viewIsLoaded: Bool = false
    private var normalState: MenuListViewInterface
    
    // For MenuListPresenterInterface
    private var MenuListViewOptions: (() -> MenuListViewOptions)?
    
    // For MenuListPresenterResponseInterface
    private var viewDidLoad: ((_ sender: MenuListViewInterface)->())?
    private var viewDidDisappear: ((_ sender: MenuListViewInterface)->())?
    private var viewDidSelectStore: ((_ store: StoreEntity)->())?
    
    private func setNormalState() {
        if let block = self.MenuListViewOptions {
            switch block() {
            case .regularView:
                self.normalState = ViewOptionsContainer.option1
            }
            
        }
        // set actions for view response
        self.normalState.didLoadBlock = self.viewDidLoad
        self.normalState.didDisappearBlock = self.viewDidDisappear
        self.normalState.didSelectStoreBlock = self.viewDidSelectStore
    }
    
    private func present(menuListViewController: UIViewController, animated: Bool = false) {
        //RootController.shareInstance?.setFrontViewPosition(FrontViewPosition.left, animated: animated)
        RootController.shareInstance?.setRear(menuListViewController, animated: animated)
    }
    
    //MARK: - MenuListPresenterInterface Implementation
    convenience required init() {
        self.init(normalState: ViewOptionsContainer.option1)
    }
    
    required init(normalState: MenuListViewInterface) {
        self.normalState = normalState
    }
    
    func setViewOption(_ block: @escaping () -> MenuListViewOptions) {
        if self.MenuListViewOptions == nil {
            self.MenuListViewOptions = block
        }
    }
}

//MARK: - MenuListPresenterSendDataInterface Implementation
extension MenuListPresenter: MenuListPresenterSendDataInterface {
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
            present(menuListViewController: normalState as! UIViewController, animated: false)
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

//MARK: - MenuListPresenterResponseInterface Implementation
extension MenuListPresenter: MenuListPresenterResponseInterface {
    @discardableResult
    func setViewDidLoad(_ block: @escaping (_ sender: MenuListViewInterface) -> ()) -> MenuListPresenterResponseInterface {
        if self.viewDidLoad == nil {
            self.viewDidLoad = block
        }
        return self
    }
    
    @discardableResult
    func setViewDidDisappear(_ block: @escaping (_ sender: MenuListViewInterface) -> ()) -> MenuListPresenterResponseInterface {
        if self.viewDidDisappear == nil {
            self.viewDidDisappear = block
        }
        return self
    }
    
    @discardableResult
    func setViewDidSelectStore(_ block: @escaping (_ store: StoreEntity) -> ()) -> MenuListPresenterResponseInterface {
        if self.viewDidSelectStore == nil {
            self.viewDidSelectStore = block
        }
        return self
    }
}
