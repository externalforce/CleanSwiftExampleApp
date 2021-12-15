//
//  ProductListViewController.swift
//  CicekSepetiCaseApp
//
//  Created by KS Murat Turan on 18.07.2019.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductListDisplayLogic: class {
    func displayProducts(viewModel: ProductList.GetProducts.ViewModel)
    func displayEmpty(_ message: String)
    func displayError(_ message: String)
}

class ProductListViewController: UIViewController {
    var interactor: ProductListBusinessLogic?
    var router: (NSObjectProtocol & ProductListRoutingLogic & ProductListDataPassing)?
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    var cellTypes: [CellType] = []
    var productsViewModel: [ProductViewModel] = []
    
    enum CellType {
        case product
        case empty
    }
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ProductListInteractor()
        let presenter = ProductListPresenter()
        let router = ProductListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupRefreshControl()
        fetchProductList()
    }
    
    func configureTableView() {
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        tableView.register(UINib(nibName: "EmptyCell", bundle: nil), forCellReuseIdentifier: "EmptyCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        navigationItem.title = "Products"
    }
    
    func fetchProductList() {
        interactor?.fetchProducts()
    }
    
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    @objc func pullToRefresh() {
        fetchProductList()
    }
    
    func loadProductsTableView() {
        cellTypes = []
        if productsViewModel.isEmpty {
            cellTypes = [.empty]
        } else {
            cellTypes += Array(repeating: .product, count: productsViewModel.count)
        }
        tableView.reloadData()
    }
}
extension ProductListViewController:ProductListDisplayLogic {
    func displayProducts(viewModel: ProductList.GetProducts.ViewModel) {
        refreshControl.endRefreshing()
        productsViewModel = viewModel.displayProducts
        loadProductsTableView()
    }
    
    func displayEmpty(_ message: String) {
        let alert = UIAlertController(title: "Network Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayError(_ message: String) {
        let alert = UIAlertController(title: "Network Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellTypes[indexPath.row] {
        case .product:
            return configureProductCell(indexPath: indexPath)
        case .empty:
            return configureEmptyCell(indexPath: indexPath)
        }
    }
    
    func configureProductCell(indexPath: IndexPath) -> ProductCell {
        let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        productCell.configureCell(model: productsViewModel[indexPath.row])
        return productCell
    }
    
    func configureEmptyCell(indexPath: IndexPath) -> EmptyCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell") as! EmptyCell
        return cell
    }
}
