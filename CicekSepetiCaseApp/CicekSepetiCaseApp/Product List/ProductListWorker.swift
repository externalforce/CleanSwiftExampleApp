//
//  ProductListWorker.swift
//  CicekSepetiCaseApp
//
//  Created by KS Murat Turan on 18.07.2019.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Alamofire

class ProductListWorker {
    
    // MARK: Properties
    let cicekSepetiURL = "https://api.ciceksepeti.com/v1/product/ch/dynamicproductlist"
    
    // MARK: Methods
    func fetchProductList(success: @escaping(ProductBaseModel) -> Void , fail: @escaping(ErrorModel) -> Void) {
        Alamofire.request(cicekSepetiURL)
            .validate()
            .response { (response) in
                if let data = response.data {
                    do {
                        let result = try JSONDecoder().decode(ProductBaseModel.self, from: data)
                        success(result)
                    } catch {
                        let error: ErrorModel = ErrorModel.networkError
                        fail(error)
                    }
                } else {
                    let error: ErrorModel = ErrorModel.networkError
                    fail(error)
                }
        }
    }
}
