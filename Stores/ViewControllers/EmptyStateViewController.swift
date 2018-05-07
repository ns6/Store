//
//  EmptyStateViewController.swift
//  Stores
//
//  Created by ssion on 5/6/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import UIKit

protocol EmptyStateViewControllerInterface: Storyboardable {
    
}
class EmptyStateViewController: UIViewController, EmptyStateViewControllerInterface {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 262
            menuButton?.target = revealViewController()
            menuButton?.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

}
