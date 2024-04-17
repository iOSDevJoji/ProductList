//
//  CartViewController.swift
//  ProductList
//
//  Created by u2233825 on 08/04/24.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    let viewModel: CartViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPTableView()
        populateUI()
    }
    
    init() {
        viewModel = CartViewModel()
        super.init(nibName: "CartViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("You should not instantiate this view controller by invoking init(coder:).")
    }
    
    func setUPTableView() {
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.estimatedRowHeight = 112
        productTableView.register(
            UINib(
                nibName: "ProductListTableViewCell",
                bundle: nil
            ),
            forCellReuseIdentifier: "ProductListTableViewCell"
        )
    }
    
    func populateUI() {
        self.title = AppConstants.cartTitle
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfProducts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productCell = productTableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell", for: indexPath) as? ProductListTableViewCell else {
            return UITableViewCell()
        }
        productCell.populateProducDetail(product: viewModel.getProduct(at: indexPath.row))
        return productCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
