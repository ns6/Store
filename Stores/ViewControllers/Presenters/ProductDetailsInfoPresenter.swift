import Foundation

class ProductDetailsInfoPresenter: ProductsListPresenter {
    
    override var indexRow: UInt { return 0 }
    let brandName: String
    let sex: String
    let color: String
    let purchasePrice: String
    let sellPrice: String
    let comment: String
    
    override init(product: Product) {
        self.brandName = product.brand?.name ?? "-"
        self.sex = product.sex
        self.color = product.color
        self.purchasePrice = String(product.purchasePrice)
        self.sellPrice = String(product.sellPrice)
        self.comment = product.comment
        super.init(product: product)
    }
}
