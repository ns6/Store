import UIKit
import TableKit

class ProductDetailsInfoCell: UITableViewCell, ConfigurableCell {
    
    typealias T = ProductDetailsInfoPresenter
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var purchasePrice: UILabel!
    @IBOutlet weak var sellPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with product: ProductDetailsInfoPresenter) {
        self.name.text = product.name
        self.sex.text = product.sex
        self.color.text = product.color
        self.purchasePrice.text = product.purchasePrice
        self.sellPrice.text = product.sellPrice
    }
    
    static var estimatedHeight: CGFloat? {
        return 227.0
    }
    
    static var defaultHeight: CGFloat? {
        return 227.0
    }
}
