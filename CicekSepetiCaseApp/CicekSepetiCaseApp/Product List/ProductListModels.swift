//
//  ProductListModels.swift
//  CicekSepetiCaseApp
//
//  Created by KS Murat Turan on 18.07.2019.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum ProductList {
    // MARK: Use cases
    
    enum GetProducts {
        struct Request {
        }
        
        struct Response {
            var productListModel: [ProductModel]?
            var message: String? 
        }
        
        struct ViewModel {
            var displayProducts: [ProductViewModel]
        }
    }
}
