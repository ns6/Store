//
//  mainScreen.swift
//  Stores
//
//  Created by ssion on 10/6/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import Foundation

import UIKit

class mainScreen: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {
            //            revealViewController().rearViewRevealWidth = 62
            
            //            butt.target = revealViewController()
            //            butt.action = #selector(SWRevealViewController.revealToggle(_:))
            //            revealViewController().rightViewRevealWidth = 150
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            let deadlineTime = DispatchTime.now() + .seconds(5)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.label.isHidden = false
                print("\n\n\nSHOW\n\n\n")
            }
        }
    }
    
}

