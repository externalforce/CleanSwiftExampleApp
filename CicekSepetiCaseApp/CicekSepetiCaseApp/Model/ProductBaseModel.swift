//
//  ProductBaseModel.swift
//  CicekSepetiCaseApp
//
//  Created by KS Murat Turan on 18.07.2019.
//

import Foundation

struct ProductBaseModel:Decodable {
    var result: ResultModel?
}

struct ResultModel:Decodable {
    var data: DataModel?
}

struct DataModel:Decodable {
    var products: [ProductModel]
}


