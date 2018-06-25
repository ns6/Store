//
//  BrandCellView.swift
//  Stores
//
//  Created by ssion on 10/8/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import UIKit
import TableKit

class BrandCellView: UITableViewCell, ConfigurableCell {
    
    typealias T = BrandEntity
    
    public var id: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with brand: BrandEntity) {
        self.textLabel?.text = brand.name
        self.id = brand.id
    }
}
