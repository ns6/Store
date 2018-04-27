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
 /*
    @IBOutlet weak var tableVW: UITableView! {
        didSet {
            tableDirector = TableDirector(tableView: tableVW)
            section = TableSection.init()
            tableDirector += section
            dataProvider = DataProviderFactory<Brand>.GetDataProvider.brandsList(storeId: store.id)
            dataProviderSizesTypes = DataProviderFactory<SizesType>.GetDataProvider.sizesTypesList(storeId: store.id)
        }
    }
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var store: Store!
    private var dataProvider: DataProvider<Brand>!
    private var dataProviderSizesTypes: DataProvider<SizesType>!
    private var tableDirector: TableDirector!
    private var section: TableSection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "top.png"), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
        
        //self.tableDirector.sections.first?.headerTitle = "TITLE"
        //let db = Firestore.firestore().collection("Stores/\(store.id)/Brands").whereField("count", isGreaterThan: 0)
                
        dataProviderSizesTypes.newData { [unowned self] (sizesTypes) in //New data coming
                self.store.sizes.append(contentsOf: sizesTypes)
            }.modifiedData { (brands) in //Data modified
                
            }.removedData { (brands) in //Remove data
                
            }.listen()
        
        //.filter(field: "count", isGreaterThan: 0)
        dataProvider.newData { [unowned self] (brands) in //New data coming
                self.store.addBrands(brands)
                self.tableDirector.insert(cellType: BrandCellView.self, items: brands, inSection: 0, withUpdate: .top, configure: { (cell) in
                    cell.on(.click) { (options) in
                        //return true
                        }
                        .on(.canEdit) { (options) -> Bool in
                            return true
                        }
//                        .on(.clickDelete) { [weak self] (options) in
//                            self?.dataProvider
//                                .Store(value: self.store.id)
//                                .Brand(value: options.item.id)
//                                .deleteObject(completion: { (err) in
//                                    if let err = err { fatalError(err.localizedDescription) }
//                                })
//                        }
                })
            }.modifiedData { [unowned self] (brands) in //Data modified
                self.store.modifyBrands(brands)
                self.tableDirector.modify(cellType: BrandCellView.self, items: brands, inSection: 0)
            }.removedData { [unowned self] (brands) in //Remove data
                self.store.removeBrands(brands)
                self.tableDirector.remove(items: brands, inSection: 0, withUpdate: .left)
            }.listen()
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
*/
}

