//
//  ProductCellView.swift
//  Stores
//
//  Created by ssion on 10/8/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import UIKit
import TableKit

class ProductCellView: UITableViewCell, ConfigurableCell {
    
    typealias T = ProductsListPresenter
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var sold: UILabel!
    @IBOutlet weak var instock: UILabel!
    @IBOutlet weak var sizesStack: UIStackView!
    
    public var id: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static var estimatedHeight: CGFloat? {
        return 223.0
    }
    
    static var defaultHeight: CGFloat? {
        return 223.0
    }
    
    func configure(with product: ProductsListPresenter) {
        self.id = product.id
        self.name.text = product.name
        self.sold.text = product.sold
        self.instock.text = product.instock
        
        CreateSizesView.clearStackView(stackView: sizesStack)
        CreateSizesView.configureSizes(sizes: product.sizes, soldSizes: product.soldSizes, stackView: sizesStack)
    }
}
