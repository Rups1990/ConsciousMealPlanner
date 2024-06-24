//
//  SearchGroceriesViewModel.swift
//  ConsciousMealPlanner
//
//  Created by Rubha on 23/06/24.
//

import Foundation
import Combine

protocol SearchGroceriesResultUpdater: AnyObject {
    func updateView(with model: [Product])
    func updateView(with error: ServiceError)
}

final class SearchGroceriesViewModel {
    private let service = SearchGroceryService()
    private(set) var products: [Product] = []
    weak var searchResultUpdater: SearchGroceriesResultUpdater?

    func fetchMatchingGroceryItem(for text: String) {
        service.fetchMatchingGroceryItem(text) { [weak self] result in
            switch result {
            case .success(let products):
                if let products = products.products {
                    self?.products = products
                    self?.searchResultUpdater?.updateView(with: products)
                } else {
                    self?.searchResultUpdater?.updateView(with: ServiceError.resultNotFound)
                }
            case .failure:
                self?.searchResultUpdater?.updateView(with: ServiceError.maxLimitReached)
            }
        }
    }
    
}
