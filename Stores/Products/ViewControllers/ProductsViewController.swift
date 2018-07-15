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
    typealias EntityType = ProductEntity
    
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
    
    var didLoad: ((_ sender: UIViewController)->())?
    var didDisappear: ((_ sender: UIViewController)->())?
    var didSelectEntity: ((ProductEntity) -> ())?
    
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

extension ProductsViewController: ViewControllerProtocol {
    
    func newData(entity: [ProductEntity]) {
        
        guard self.isDidLoad else {
            self.buffer.append(contentsOf: entity)
            return
        }
        
        let presenter = entity.map{ ProductsListPresenter(product: $0) }
        
        self.tableDirector?.insert(cellType: ProductCellView.self,
          items: presenter,
          inSection: 0,
          withUpdate: .top,
          configure: { (cell) in
            cell.on(.click) { (options) in
                self.didSelectEntity?(options.item.product)
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
