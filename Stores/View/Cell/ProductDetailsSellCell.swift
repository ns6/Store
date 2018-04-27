//
//  ProductDetailsSellCell.swift
//  Stores
//
//  Created by ssion on 3/3/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import UIKit
import TableKit

class ProductDetailsSellCell: UITableViewCell, ConfigurableCell {

    typealias T = ProductEntity
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with product: ProductEntity) {
        
    }
    
    static var estimatedHeight: CGFloat? {
        return 44.0
    }
    
    static var defaultHeight: CGFloat? {
        return 44.0
    }

}
