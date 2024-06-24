//
//  GroceryProducts.swift
//  ConsciousMealPlanner
//
//  Created by Rubha on 23/06/24.
//

import Foundation

struct GroceryProducts : Codable {
    let products : [Product]?
    let totalProducts : Int?
    let type : String?
    let offset : Int?
    let number : Int?
}

struct Product : Codable {
    let id : Int?
    let title : String?
    let imageType : String?
}

