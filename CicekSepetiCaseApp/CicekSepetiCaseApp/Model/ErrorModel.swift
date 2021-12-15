//
//  ErrorModel.swift
//  CicekSepetiCaseApp
//
//  Created by KS Murat Turan on 19.07.2019.
//

import Foundation

enum ErrorModel: Error {
    case networkError
}

extension ErrorModel: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .networkError:
            return NSLocalizedString("Description of network error", comment: "Network Error")
        }
    }
}
