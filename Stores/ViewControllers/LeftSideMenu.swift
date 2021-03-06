//  ViewControl of LeftSideMenu
//  LeftSideMenu.swift
//  Stores
//
//  Created by ssion on 10/6/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import UIKit
import Foundation
import FirebaseFirestore
import TableKit

class LeftSideMenu: UITableViewController {
    
    @IBOutlet weak var tableVW: UITableView! {
        didSet {
            tableDirector = TableDirector(tableView: tableVW)
            sectionFirst = TableSection.init()
            sectionSecond = TableSection.init()
            tableDirector += sectionFirst
            tableDirector += sectionSecond
            dataProvider = DataProviderFactory<Store>.GetDataProvider.leftSideMenu()
        }
    }
    
    private var dataProvider: DataProvider<Store>!
    private var tableDirector: TableDirector!
    private var sectionFirst: TableSection!
    private var sectionSecond: TableSection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        //self.sectionFirst.headerTitle = "Меню";
        //self.sectionSecond.headerTitle = "Магазины"
        
        //Create static first section
        let newsRow = TableRow<MenuCell>(item: "Лента Новостей")
            .on(.click) { (options) in
                //return true
            }
            .on(.canEdit) { (options) -> Bool in
                return false
        }
        let statisticsRow = TableRow<MenuCell>(item: "Статистика")
            .on(.click) { (options) in
                //return true
            }
            .on(.canEdit) { (options) -> Bool in
                return false
        }
        self.tableDirector.insert(row: newsRow, atIndex: 0, inSection: 0, withUpdate: .top)
        self.tableDirector.insert(row: statisticsRow, atIndex: 1, inSection: 0, withUpdate: .top)
        //end
        
        dataProvider.newData { [unowned self] (stores) in //New data coming
                self.tableDirector.insert(cellType: MenuStoresCell.self, items: stores, inSection: 1, withUpdate: .top,
                configure: { (cell) in
                    cell.on(.click) { (options) in
                        //return true
                        }
                        .on(.canEdit) { (options) -> Bool in
                            return false
                        }
                })
            }.modifiedData { (stores) in //Data modified
                self.tableDirector.modify(cellType: MenuStoresCell.self, items: stores, inSection: 1)
            }.removedData { (stores) in //Remove data
                self.tableDirector.remove(items: stores, inSection: 1, withUpdate: .left)
            }.listen()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BrandsList" {
            guard let indexPath = tableVW.indexPathForSelectedRow else {fatalError()}
            guard let item = self.tableDirector.item(forCellType: MenuStoresCell.self, inSection: indexPath.section, rowIndex: indexPath.row) else { fatalError() }
//          let controller = (segue.destination as! UINavigationController).topViewController as! BrandsList
            guard let controller = ((segue.destination as? UITabBarController)?
                                            .viewControllers?.first as? UINavigationController)?
                                            .topViewController as? BrandsList else {fatalError()}
                controller.store = item
                controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
}


