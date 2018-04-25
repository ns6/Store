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

class BrandsList: UITableViewController {
    
    @IBOutlet var tableVW: UITableView!
    var store: Store!
    
    private var dataProvider: DataProvider<Brand>!
    
    deinit {
        self.dataProvider.stopListening()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let store = self.store else { return }
        let db = Firestore.firestore().collection("Stores/\(store.name)/Brands")
        self.dataProvider = DataProvider<Brand>(query: db)
        
        self.dataProvider.listen { [unowned self] (brands, docChanges) in
            var addIndexPaths: [IndexPath] = []
            var deleteIndexPaths: [IndexPath] = []
            
            self.tableVW.beginUpdates()

            for change in docChanges {
                if change.type == .removed {
                    let id = change.document.documentID
                    guard let cells = self.tableVW.visibleCells as? [BrandCellView] else {return}
                    guard let cell = cells.filter({ $0.id == id }).first else {return}
                    guard let indexPath = self.tableVW.indexPath(for: cell) else {return}
                    deleteIndexPaths.append(indexPath)
                    
                }
                else {
                    let index = self.dataProvider.index(of: change.document)!
                    let indexPath = IndexPath(row: index, section: 0)
                    
                    if change.type == .added {
                        addIndexPaths.append(indexPath)
                    } else if change.type == .modified {
                        guard let cell = self.tableVW.cellForRow(at: indexPath) as? BrandCellView else {return}
                        self.configureCell(cell, withBrand: self.dataProvider[index]!)
                    }
                }
                
            }
            self.tableVW.deleteRows(at: deleteIndexPaths, with: .automatic)
            self.tableVW.insertRows(at: addIndexPaths, with: .automatic)
            self.tableVW.endUpdates()
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if revealViewController() != nil {
            //            revealViewController().rearViewRevealWidth = 62
            
            //            butt.target = revealViewController()
            //            butt.action = #selector(SWRevealViewController.revealToggle(_:))
            //            revealViewController().rightViewRevealWidth = 150
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataProvider.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrandName", for: indexPath) as! BrandCellView
        
        let brand = self.dataProvider[indexPath.row]!
        configureCell(cell, withBrand: brand)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //        if editingStyle == .delete {
        //            objects.remove(at: indexPath.row)
        //            tableView.deleteRows(at: [indexPath], with: .fade)
        //        } else if editingStyle == .insert {
        //            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        //        }
    }
    
    private func configureCell(_ cell: BrandCellView, withBrand brand: Brand) {
        cell.id = brand.id
        cell.textLabel!.text = brand.name
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductsList" {
            if let indexPath = tableVW.indexPathForSelectedRow {
                let object = self.dataProvider[indexPath.row]
                let controller = segue.destination as! ProductsList
                controller.store = self.store
                controller.brand = object
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    
    @IBAction func addBrand(_ sender: Any) {
        let ref = Firestore.firestore().collection("Stores").document(store.name).collection("Brands")
        DataWriter.addObject(collectionRef: ref, dictionary: ["name" : "NEW Brand", "count": 5])
    }

}
