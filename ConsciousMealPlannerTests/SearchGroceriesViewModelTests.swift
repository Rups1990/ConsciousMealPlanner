//
//  ConsciousMealPlannerTests.swift
//  ConsciousMealPlannerTests
//
//  Created by Rubha on 23/06/24.
//

import XCTest
@testable import ConsciousMealPlanner

final class SearchGroceryService: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testIfDecodingIsSuccessful() {
        if let url = Bundle.main.url(forResource: "MockSearchGroceriesResult", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let model = try? JSONDecoder().decode(GroceryProducts.self, from: data) {
            XCTAssertNotNil(model)
        }
    }

}
