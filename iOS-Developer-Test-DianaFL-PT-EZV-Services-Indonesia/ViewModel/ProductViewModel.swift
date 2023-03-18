//
//  ProductViewModel.swift
//  iOS-Developer-Test-DianaFL-PT-EZV-Services-Indonesia
//
//  Created by Diana Febrina Lumbantoruan on 18/03/23.
//

import Foundation

class ProductViewModel {
    
    var networkApiService = NetworkingAPIService()
    
    func getDataProduct(completion : @escaping(Result<ProductResponse, Error>) -> Void) {
        networkApiService.getDataProduct(completion: completion)
    }
}
