//
//  BrandListPresenter.swift
//  Stores
//
//  Created by ssion on 5/4/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation

protocol BrandsPresenterProtocol {
    var empty: Storyboardable { get }
    var normal: BrandsViewControllerProtocol { get }
    
    var didLoad: ((_ sender: BrandsViewControllerProtocol)->())? {get set}
    var didDisappear: ((_ sender: BrandsViewControllerProtocol)->())? {get set}
    var didSelectBrand: ((_ brand: BrandEntity)->())? {get set}
}

class BrandPresenter: BrandsPresenterProtocol {
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
    
    var normal: BrandsViewControllerProtocol {
        guard let current = actual as? BrandsViewController else {
            let current = BrandsViewController.storyboardViewController()
            
            //set callBack
            current.didLoad = self.didLoad
            current.didDisappear = self.didDisappear
            current.didSelectBrand = self.didSelectBrand
            
            actual = current
            present(vc: current, animated: true)
            return current
        }
        return current
    }
    
    var didLoad: ((_ sender: BrandsViewControllerProtocol)->())?
    var didDisappear: ((_ sender: BrandsViewControllerProtocol)->())?
    var didSelectBrand: ((_ brand: BrandEntity)->())?
    
    private func present(vc: UIViewController, animated: Bool = false) {
        let navController = UINavigationController(rootViewController: vc)
        RootController.shareInstance?.setFrontViewPosition(FrontViewPosition.left, animated: animated)
        RootController.shareInstance?.setFront(navController, animated: animated)
    }
}

/*
protocol BrandListPresenterInterface {
    init()
    init(emptyState: EmptyStateViewControllerInterface, normalState: BrandsListViewInterface)
    func setViewOption(_: @escaping () -> ViewOptions)
}

protocol BrandListPresenterSendDataInterface {
    func newData(_ brands: [BrandEntity])
    func modifiedData(_ brands: [BrandEntity])
    func removedData(_ brands: [BrandEntity])
}

protocol BrandListPresenterResponseInterface{
    @discardableResult
    func setViewDidLoad(_: @escaping (_ sender: BrandsListViewInterface)->()) -> BrandListPresenterResponseInterface
    @discardableResult
    func setViewDidDisappear(_: @escaping (_ sender: BrandsListViewInterface)->()) -> BrandListPresenterResponseInterface
    @discardableResult
    func setViewDidSelectBrand(_: @escaping (_ brand: BrandEntity)->()) -> BrandListPresenterResponseInterface
}

enum ViewOptions {
    case regularView
}

class BrandListPresenter: BrandListPresenterInterface {
    private struct ViewOptionsContainer {
        static let option1: BrandsListViewInterface = BrandsListViewController.storyboardViewController()
    }

    private var viewIsLoaded: Bool = false
    private let emptyState: EmptyStateViewControllerInterface
    private var normalState: BrandsListViewInterface

    // For BrandListPresenterInterface
    private var viewOptions: (() -> ViewOptions)?

    // For BrandListPresenterResponseInterface
    private var viewDidLoad: ((_ sender: BrandsListViewInterface)->())?
    private var viewDidDisappear: ((_ sender: BrandsListViewInterface)->())?
    private var viewDidSelectBrand: ((_ brand: BrandEntity)->())?

    private func setNormalState() {
        if let block = self.viewOptions {
            switch block() {
            case .regularView:
                self.normalState = ViewOptionsContainer.option1
            }
            
        }
        // set actions for view response
        self.normalState.didLoadBlock = self.viewDidLoad
        self.normalState.didDisappearBlock = self.viewDidDisappear
        self.normalState.didSelectBrandBlock = self.viewDidSelectBrand
    }
    
    private func present(viewController: UIViewController, animated: Bool = true) {
        let navController = UINavigationController(rootViewController: viewController)
        RootController.shareInstance?.setFrontViewPosition(FrontViewPosition.left, animated: animated)
        RootController.shareInstance?.pushFrontViewController(navController, animated: animated)
    }

    //MARK: - BrandListPresenterInterface Implementation
    convenience required init() {
        self.init(emptyState: EmptyStateViewController.storyboardViewController(), normalState: ViewOptionsContainer.option1)
    }

    required init(emptyState: EmptyStateViewControllerInterface, normalState: BrandsListViewInterface) {
        self.emptyState = emptyState
        self.normalState = normalState
        self.present(viewController: emptyState as! UIViewController)
    }

    func setViewOption(_ block: @escaping () -> ViewOptions) {
        if self.viewOptions == nil {
            self.viewOptions = block
        }
    }
}

//MARK: - BrandListPresenterSendDataInterface Implementation
extension BrandListPresenter: BrandListPresenterSendDataInterface {
    func newData(_ brands: [BrandEntity]) {
        if self.viewIsLoaded == false {

            let tmpViewDidLoadBlock = self.viewDidLoad
            self.viewDidLoad = nil

            self.viewDidLoad = { [weak self] (this)  in
                if tmpViewDidLoadBlock != nil {
                    tmpViewDidLoadBlock!(this)
                }
                self?.viewIsLoaded = true
                this.newData(entity: brands)
            }
            setNormalState()

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

//MARK: - BrandListPresenterResponseInterface Implementation
extension BrandListPresenter: BrandListPresenterResponseInterface {
    @discardableResult
    func setViewDidLoad(_ block: @escaping (_ sender: BrandsListViewInterface) -> ()) -> BrandListPresenterResponseInterface {
        if self.viewDidLoad == nil {
            self.viewDidLoad = block
        }
        return self
    }

    @discardableResult
    func setViewDidDisappear(_ block: @escaping (_ sender: BrandsListViewInterface) -> ()) -> BrandListPresenterResponseInterface {
        if self.viewDidDisappear == nil {
            self.viewDidDisappear = block
        }
        return self
    }

    @discardableResult
    func setViewDidSelectBrand(_ block: @escaping (_ brand: BrandEntity) -> ()) -> BrandListPresenterResponseInterface {
        if self.viewDidSelectBrand == nil {
            self.viewDidSelectBrand = block
        }
        return self
    }
}
*/
