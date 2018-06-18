//
//  ProductsList.swift
//  Stores
//
//  Created by ssion on 10/6/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import Foundation
import UIKit
import TableKit

class ProductsViewController: UITableViewController {
    
    @IBOutlet weak var tableVW: UITableView! {
        didSet {
            tableDirector = TableDirector(tableView: tableVW)
            section = TableSection.init()
            tableDirector += section
            
        }
    }
    
    private var tableDirector: TableDirector!
    private var section: TableSection!
    private var buffer: [ProductEntity] = []
    private var isDidLoad: Bool = false
    
    var didLoad: ((_ sender: ProductsViewControllerProtocol)->())?
    var didDisappear: ((_ sender: ProductsViewControllerProtocol)->())?
    var didSelectBrand: ((_ brand: ProductEntity)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isDidLoad = true
        if self.buffer.count > 0 {
            newData(entity: buffer)
            self.buffer = []
        }
        didLoad?(self)
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        didDisappear?(self)
    }
    
    deinit {
        print("DEINIT")
    }
}

extension ProductsViewController: ProductsViewControllerProtocol {
    
    func newData(entity: [ProductEntity]) {
        
        guard self.isDidLoad else {
            self.buffer.append(contentsOf: entity)
            return
        }
        
        let presenter = entity.map{ ProductsListPresenter(product: $0) }
        
        self.tableDirector.insert(cellType: ProductCellView.self,
          items: presenter,
          inSection: 0,
          withUpdate: .top,
          configure: { (cell) in
            cell.on(.click) { (options) in
                //return true
                }
                .on(.canEdit) { (options) -> Bool in
                    return false
            }
        })
    }
    
    func modifiedData(entity: [ProductEntity]) {
        let presenter = entity.map{ ProductsListPresenter(product: $0) }
        self.tableDirector.modify(cellType: ProductCellView.self, items: presenter, inSection: 0)
    }
    
    func removedData(entity: [ProductEntity]) {
        self.tableDirector.remove(items: entity, inSection: 0, withUpdate: .left)
    }
}

/*
class ProductsList: UITableViewController {

    @IBOutlet weak var tableVW: UITableView! {
        didSet {
            tableDirector = TableDirector(tableView: tableVW)
            section = TableSection.init()
            tableDirector += section
            dataProvider = DataProviderFactory<ProductEntity>.GetDataProvider.productsList(storeId: store.id, brandId: brand.id)
        }
    }
    
    var store: StoreEntity!
    var brand: BrandEntity!
    private var dataProvider: DataProvider<ProductEntity>!
    private var tableDirector: TableDirector!
    private var section: TableSection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataProvider.newData { [unowned self] (products) in //New data coming
                self.brand.addProducts(products)
                let presenter = products.map{ ProductsListPresenter(product: $0) }
                self.tableDirector.insert(cellType: ProductCellView.self, items: presenter, inSection: 0, withUpdate: .top, configure: { (cell) in
                    cell.on(.click) { (options) in
                        //return true
                        }
                        .on(.canEdit) { (options) -> Bool in
                            return false
                        }
                })
            }.modifiedData { [unowned self] (products) in //Data modified
                self.brand.modifyProducts(products)
                let presenter = products.map{ ProductsListPresenter(product: $0) }
                self.tableDirector.modify(cellType: ProductCellView.self, items: presenter, inSection: 0)
            }.removedData { [unowned self] (products) in //Remove data
                self.brand.removeProducts(products)
                self.tableDirector.remove(items: products, inSection: 0, withUpdate: .left)
            }.listen()
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
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductDetail" {
            guard let indexPath = tableVW.indexPathForSelectedRow else {fatalError()}
            let controller = segue.destination as! ProductDetail
            controller.product = self.brand.products[indexPath.row]
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }

}
*/
