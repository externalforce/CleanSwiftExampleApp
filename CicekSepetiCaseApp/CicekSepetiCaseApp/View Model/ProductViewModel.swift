//
//  ProductViewModel.swift
//  CicekSepetiCaseApp
//
//  Created by KS Murat Turan on 18.07.2019.
//

import Foundation

final class ProductViewModel {
    
    // MARK: Properties
    var productModel: ProductModel!
    
    private(set) var name: String!
    private(set) var oldPrice: Double!
    private(set) var newPrice: Double!
    private(set) var installment: String!
    private(set) var imageURL: URL!
    
    init(productModel: ProductModel) {
        self.productModel = productModel
        self.name = productModel.name
        self.oldPrice = getOldPrice()
        self.newPrice = getNewPrice()
        self.installment = productModel.installmentText
        self.imageURL = getImageURL()
    }
    
    // MARK: - Helper Methods
    func getOldPrice() -> Double {
        return productModel.price?.old ?? 0.0
    }
    func getNewPrice() -> Double {
        return productModel.price?.total ?? 0.0
    }
    func getImageURL() -> URL {
        return URL(string: productModel.image!)!
    }
}
