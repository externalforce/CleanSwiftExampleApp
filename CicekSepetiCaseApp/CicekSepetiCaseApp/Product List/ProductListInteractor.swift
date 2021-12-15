//
//  ProductListInteractor.swift
//  CicekSepetiCaseApp
//
//  Created by KS Murat Turan on 18.07.2019.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProductListBusinessLogic {
    func fetchProducts()
}

protocol ProductListDataStore {
    //var name: String { get set }
}

class ProductListInteractor: ProductListBusinessLogic, ProductListDataStore {

    var presenter: ProductListPresentationLogic?
    var worker: ProductListWorker? = ProductListWorker()

    var products: [ProductModel] = []
    
    // MARK: Methods
    func fetchProducts() {
        worker?.fetchProductList(success: { (productBaseModel) in
            self.products = (productBaseModel.result?.data?.products)!
            let response = ProductList.GetProducts.Response(productListModel: self.products, message: nil)
            self.presenter?.presentFetchedProducts(response: response)
        }, fail: { (error) in
            let response = ProductList.GetProducts.Response(productListModel: self.products, message: error.errorDescription)
            self.presenter?.presentFetchedProducts(response: response)
        })
    }
}
