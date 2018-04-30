//
//  BrandsList.swift
//  Stores
//
//  Created by ssion on 10/1/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import TableKit

class BrandsList: UITableViewController {
 
    @IBOutlet weak var tableVW: UITableView! {
        didSet {
            tableDirector = TableDirector(tableView: tableVW)
            section = TableSection.init()
            tableDirector += section
            
        }
    }
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    private var controller: MenuListControllerInterface!
    
    
    private var tableDirector: TableDirector!
    private var section: TableSection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "top.png"), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
        
        //self.tableDirector.sections.first?.headerTitle = "TITLE"
        //let db = Firestore.firestore().collection("Stores/\(store.id)/Brands").whereField("count", isGreaterThan: 0)
                
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 262
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductsList" {
            guard let indexPath = tableVW.indexPathForSelectedRow else {fatalError()}
//            guard let item = self.tableDirector.item(forCellType: BrandCellView.self, inSection: 0, rowIndex: indexPath.row) else { fatalError() }
            let controller = segue.destination as! ProductsList
            controller.store = self.store
            controller.brand = self.store.brands[indexPath.row]
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
    private func newBrand(name: String) {
//        let newBrand = Brand(id: "", indexRow: 0, name: name, count: 0, products: [])
//        self.dataProvider
//            .Store(value: self.store.id)
//            .Brand(value: "")
//            .addObject(model: newBrand) { (err) in
//                if let err = err { fatalError(err.localizedDescription) }
//        }
    }
    
    @IBAction func addBrand(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Новый Бренд", message: "", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Имя Бренда"
            textField.keyboardType = .default
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel) { action in
            print(action)
        }
        alertController.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { [weak alertController, unowned self] _ in
            guard let alertController = alertController else { fatalError() }
            guard let textField = alertController.textFields?.first else { fatalError() }
            guard let name = textField.text else { fatalError() }
            self.newBrand(name: name)
            
        }
        alertController.addAction(addAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
    }
}

extension BrandsList: BrandsListViewInterface {
    
}
