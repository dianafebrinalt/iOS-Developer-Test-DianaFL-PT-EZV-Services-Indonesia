//
//  NetworkAPIService.swift
//  iOS-Developer-Test-DianaFL-PT-EZV-Services-Indonesia
//
//  Created by Diana Febrina Lumbantoruan on 18/03/23.
//

import Foundation

class NetworkingAPIService {
    
    func getDataProduct(completion : @escaping(Result<ProductResponse, Error>) -> Void) {
        let API_URL = "https://dummyjson.com/products"
        
        guard let url = URL(string: API_URL) else {
            fatalError()
        }
        
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                print("Response is Empty or Response not detect. Try it again!")
                return
            }
            print("HTTP Status : \(response)")
            
            guard let data = data else{
                print("There is no data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonDataGame = try decoder.decode(ProductResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonDataGame))
                    print(jsonDataGame)
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

