//
//  Cell.swift
//  Stores
//
//  Created by ssion on 1/13/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import Foundation
import TableKit

protocol RowContainer: Row {
    associatedtype T
    associatedtype CellDataType
    
    var sourceCell: T {get}
    func configure(with item: CellDataType)
}

class Cell<CellType: ConfigurableCell>: TableRow<CellType>, RowContainer where CellType: UITableViewCell {
    var sourceCell: CellType?
    
    override open func configure(_ cell: UITableViewCell) {
        self.sourceCell = cell as? CellType
        super.configure(cell)
    }
    
    open func configure(with item: CellType.T) {
        guard let cell = self.sourceCell else { fatalError() }
        cell.configure(with: item)
    }
}
