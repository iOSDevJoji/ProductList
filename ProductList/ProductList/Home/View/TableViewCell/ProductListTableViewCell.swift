//
//  ProductListTableViewCell.swift
//  ProductList
//
//  Created by u2233825 on 05/04/24.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageviewAspectRatio: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func populateProducDetail(product: ProductModel?) {
        if  let thumbnail = product?.thumbnail, let imageUrl = URL(string: thumbnail) {
            productImageView.load(url: imageUrl, placeholder: nil)
        }
        if let rating = product?.rating?.stringValue {
            ratingLabel.text = "\(AppConstants.ratingTitle) \(rating)"
        }
        if let price = product?.price?.stringValue {
            priceLabel.text = "\(AppConstants.priceTitle) \(price)"
        }
        titleLabel.text = product?.title
    }
}
