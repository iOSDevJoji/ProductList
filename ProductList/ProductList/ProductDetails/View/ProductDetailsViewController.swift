//
//  ProductDetailsViewController.swift
//  ProductList
//
//  Created by u2233825 on 07/04/24.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountPercentageLabel: UILabel!
    @IBOutlet weak var descTitle: UILabel!
    @IBOutlet weak var brandTitle: UILabel!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var priceTitle: UILabel!
    @IBOutlet weak var discountTitle: UILabel!
    var viewModel: ProductDetailViewModel
    
    init(with product: ProductModel) {
        viewModel = ProductDetailViewModel(product: product)
        super.init(nibName: "ProductDetailsViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("You should not instantiate this view controller by invoking init(coder:).")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateUI()
        setUPNavigationBar()
    }
    
    func populateUI() {
        self.title = viewModel.title
        descTitle.text = AppConstants.productDescTitle
        descriptionLabel.text = viewModel.productDescription
        
        brandTitle.text = AppConstants.brandTitle
        brandLabel.text = viewModel.brand
        
        categoryTitle.text = AppConstants.categoryTitle
        categoryLabel.text = viewModel.productCategory
        
        priceTitle.text = AppConstants.priceTitle
        priceLabel.text = viewModel.productPrice
        
        discountTitle.text = AppConstants.discountPercentage
        discountPercentageLabel.text = viewModel.productDiscountPercentage
        
        if  let headerImage = viewModel.headerImageUrl, let imageUrl = URL(string: headerImage) {
            headerImageView.load(url: imageUrl, placeholder: nil)
        }
    }
    
    func navigateToCart() {
        let cartVC = CartViewController()
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    
    func setUPNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(cartButtonAction))
    }
    
    @objc
    func cartButtonAction() {
        navigateToCart()
    }
    
    @IBAction func addToCart(_ sender: Any) {
        Task {
            let isSaved = await viewModel.addToCart()
            if isSaved {
                showAlertMessage(title: AppConstants.alertTitleSuccess, message: AppConstants.addToCartMessage)
            } else {
                showAlertMessage(title: AppConstants.alertTitle, message: AppConstants.addToCartFailed)
            }
        }
    }
    
}
