//
//  ProductsList.swift
//  Stores
//
//  Created by ssion on 10/6/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import TableKit

class ProductDetail: UITableViewController {
    
    @IBOutlet weak var tableVW: UITableView!
    var product: Product!
    private var tableDirector: TableDirector!
    private var sectionInfoSizesSell: TableSection!
    private var sectionStatistics: TableSection!
    private var sectionSold: TableSection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = product.brand?.name ?? " - "
        tableDirector = TableDirector(tableView: tableVW)
        sectionInfoSizesSell = TableSection.init()
        sectionStatistics = TableSection.init()
        sectionSold = TableSection.init()
        tableDirector += sectionInfoSizesSell
        tableDirector += sectionStatistics
        tableDirector += sectionSold

        let presenter = ProductDetailsInfoPresenter(product: product)
        self.tableDirector.insert(cellType: ProductDetailsInfoCell.self, items: [presenter], inSection: 0, withUpdate: .top, configure: { (cell) in
            
        })
        
        let presenter2 = ProductDetailsSizesPresenter(product: product)
        self.tableDirector.insert(cellType: ProductDetailsSizesCell.self, items: [presenter2], inSection: 0, withUpdate: .top, configure: { (cell) in
            
        })
        
        self.tableDirector.insert(cellType: ProductDetailsSellCell.self, items: [product], inSection: 0, withUpdate: .top, configure: { (cell) in
            
        })
        
        self.tableDirector.insert(cellType: ProductDetailsStatisticsCell.self, items: [product], inSection: 1, withUpdate: .top, configure: { (cell) in
            
        })
        
        self.tableDirector.insert(cellType: ProductDetailsSoldCell.self, items: [product], inSection: 2, withUpdate: .top, configure: { (cell) in
            
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if revealViewController() != nil {
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
