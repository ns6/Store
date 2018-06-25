//
//  MenuStoresCell.swift
//  Stores
//
//  Created by ssion on 10/13/17.
//  Copyright © 2017 Prokuda. All rights reserved.
//

import UIKit
import TableKit

class MenuStoresCell: UITableViewCell, ConfigurableCell {

    public var id: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with store: StoreEntity) {
        self.textLabel?.text = store.name
        self.id = store.id
    }
}
