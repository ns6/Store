//
//  ProductDetailsSizesCell.swift
//  Stores
//
//  Created by ssion on 3/3/18.
//  Copyright © 2018 Prokuda. All rights reserved.
//

import UIKit
import TableKit

class ProductDetailsSizesCell: UITableViewCell, ConfigurableCell {

    typealias T = ProductDetailsSizesPresenter
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with product: ProductDetailsSizesPresenter) {
        CreateSizesView.clearStackView(stackView: stackView)
        CreateSizesView.configureSizes(sizes: product.sizes, soldSizes: product.soldSizes, stackView: stackView)
    }
    
    static var estimatedHeight: CGFloat? {
        return 173.0
    }
    
    static var defaultHeight: CGFloat? {
        return 173.0
    }
}
