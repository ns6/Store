//
//  BrandListPresenter.swift
//  Stores
//
//  Created by ssion on 5/4/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import UIKit

class Presenter {
    
    enum SegueType {
        case push
        case modal
    }
    
    private let rootViewController: SWRevealViewController
    private var viewControllers: [String: ()->UIViewController] = [:]
    private var actualViewController: AnyObject?
    private var navigationController: UINavigationController?
    private let shouldCreateNavigationController: Bool
    private let segueType: SegueType
    var isPresented: Bool {
        if actualViewController != nil { return true }
        return false
    }
    
    
    init(segueType: SegueType, shouldCreateNavigationController: Bool) {
        guard let rootViewController = RootController.shareInstance else {
            fatalError("SWRevealViewController - nil")
        }
        self.rootViewController = rootViewController
        self.segueType = segueType
        self.shouldCreateNavigationController = shouldCreateNavigationController
    }
    
    func add<ViewController: ViewControllerProtocol>(viewController: ViewController.Type, setOptions: @escaping (ViewController)->())
        where ViewController: UIViewController {
            //For lazy instantiation
            self.viewControllers[String(describing: ViewController.self)] = {
                let vc = viewController.storyboardViewController()
                setOptions(vc)
                return vc
            }
    }
    
    func present<ViewController: ViewControllerProtocol>() -> ViewController
        where ViewController: UIViewController {
            if let actualViewController = self.actualViewController {
                //Update data in viewController
                if actualViewController.isKind(of: ViewController.self) {
                    return actualViewController as! ViewController
                }
                
                //replace viewController
                let vc: ViewController = instantiateViewController()
                guard let navigationController = self.navigationController else {
                    fatalError("NavigationController is not exist")
                }
                
                navigationController.popViewController(animated: false)
                navigationController.pushViewController(vc, animated: false)
                return vc
            }
            
            //present new view
            let vc: ViewController = instantiateViewController()
            if shouldCreateNavigationController == true {
                createNavigationController(rootViewController: vc, animated: true)
                return vc
            }
            guard let navigationController = self.rootViewController.frontViewController as? UINavigationController else {
                fatalError("NavigationController is not exist")
            }
            self.navigationController = navigationController
            navigationController.pushViewController(vc, animated: true)
            return vc
    }
    
    private func createNavigationController(rootViewController: UIViewController, animated: Bool) {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        self.navigationController = navigationController
        self.rootViewController.setFrontViewPosition(.left, animated: true)
        self.rootViewController.setFront(navigationController, animated: animated)
    }
    
    private func instantiateViewController<ViewController: ViewControllerProtocol>() -> ViewController
        where ViewController: UIViewController {
            let id = String(describing: ViewController.self)
            guard let vcBuilder = viewControllers[id] else { fatalError("ViewController not found") }
            let vc = vcBuilder()
            self.actualViewController = vc
            return vc as! ViewController
    }
}
