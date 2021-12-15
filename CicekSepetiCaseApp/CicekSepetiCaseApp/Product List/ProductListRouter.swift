//
//  ProductListRouter.swift
//  CicekSepetiCaseApp
//
//  Created by KS Murat Turan on 18.07.2019.
//  Copyright (c) 2019 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

@objc protocol ProductListRoutingLogic {
}

protocol ProductListDataPassing {
    var dataStore: ProductListDataStore? { get }
}

class ProductListRouter: NSObject, ProductListRoutingLogic, ProductListDataPassing {
    weak var viewController: ProductListViewController?
    var dataStore: ProductListDataStore?
}
