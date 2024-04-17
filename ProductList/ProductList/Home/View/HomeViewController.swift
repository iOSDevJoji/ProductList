//
//  HomeViewController.swift
//  ProductList
//
//  Created by u2233825 on 05/04/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var productListView: UITableView!
    private let refreshControl = UIRefreshControl()
    private var viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPTableView()
        reloadProductList()
        setUPNavigationBar()
        
       
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        productListView.refreshControl = refreshControl
    }
    
    func setUPTableView() {
        productListView.delegate = self
        productListView.dataSource = self
        productListView.estimatedRowHeight = 112
        productListView.register(UINib(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductListTableViewCell")
    }
    
    func reloadProductList() {
        Task {
            let error = await viewModel.getProductList()
            if let error = error {
                showAlertMessage(title: AppConstants.alertTitle, message: error.customMessage)
            } else {
                DispatchQueue.main.async {
                    self.productListView.reloadData()
                }
                
            }
        }
    }
    
    @objc func loadData() {
        reloadProductList()
        refreshControl.endRefreshing()
    }
    
    func navigateToPDP(index: Int) {
        guard let product = viewModel.getProduct(at: index) else {
            return
        }
        let pdp = ProductDetailsViewController(with: product)
        self.navigationController?.pushViewController(pdp, animated: true)
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
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfProducts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productCell = productListView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell", for: indexPath) as? ProductListTableViewCell else {
            return UITableViewCell()
        }
        productCell.populateProducDetail(product: viewModel.getProduct(at: indexPath.row))
        return productCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToPDP(index: indexPath.row)
    }
}
