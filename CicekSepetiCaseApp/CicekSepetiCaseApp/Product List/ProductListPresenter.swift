//
//  ProductListPresenter.swift
//  CicekSepetiCaseApp
//
//  Created by KS Murat Turan on 18.07.2019.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductListPresentationLogic {
    func presentFetchedProducts(response: ProductList.GetProducts.Response)
}

class ProductListPresenter: ProductListPresentationLogic {
    weak var viewController: ProductListDisplayLogic?
    
    // MARK: Methods
    func presentFetchedProducts(response: ProductList.GetProducts.Response) {
        if let message = response.message {
            viewController?.displayError(message)
        }
        guard let model = response.productListModel else {
            viewController?.displayEmpty("Error while getting products")
            return
        }
        let filteredModel = model.filter { (product) -> Bool in
            product.productGroupId == 1 && (50...100 ~= Int((product.price?.total)!))
        }
        let productViewModel = filteredModel.compactMap {
            ProductViewModel(productModel: $0) }
        let viewModel = ProductList.GetProducts.ViewModel(displayProducts: productViewModel)
        viewController?.displayProducts(viewModel: viewModel)
    }
}
