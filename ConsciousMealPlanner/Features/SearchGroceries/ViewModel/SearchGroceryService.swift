//
//  AddGroceryService.swift
//  ConsciousMealPlanner
//
//  Created by Rubha on 23/06/24.
//

import Foundation
import Combine

enum ServiceError: Error {
    case maxLimitReached, resultNotFound
}

final class SearchGroceryService {
   
    var cancellable: [AnyCancellable] = []
    
    func fetchMatchingGroceryItem(_ item: String, completion: @escaping ((Result<GroceryProducts, Error>) -> Void)) {
        let url = URL(string:"https://api.spoonacular.com/food/products/search?query=\(item)&number=\(String(10))")!
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("API_KEY", forHTTPHeaderField: "x-api-key")
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .compactMap{ try? JSONDecoder().decode(GroceryProducts.self, from: $0.data) }
            .sink { _ in
                print("received")
            } receiveValue: { products in
                completion(.success(products))
            }
            .store(in: &cancellable)
    }
}

