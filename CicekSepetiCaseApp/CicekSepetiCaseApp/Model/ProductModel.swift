//
//  ProductModel.swift
//  CicekSepetiCaseApp
//
//  Created by KS Murat Turan on 18.07.2019.
//

import Foundation

struct ProductModel: Decodable {
    var name: String?
    var image: String?
    var price: PriceModel?
    var installment: Bool?
    var installmentText: String?
    var productGroupId: Int?
}

struct PriceModel: Decodable {
    var total: Double?
    var old: Double?
}
