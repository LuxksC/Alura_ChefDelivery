//
//  SearchStoreViewModelTest.swift
//  ChefDeliveryTests
//
//  Created by Lucas de Castro Souza on 29/07/25.
//

import XCTest
@testable import ChefDelivery

final class SearchStoreViewModelTest: XCTestCase {
    var sut: SearchStoreViewModel!
    
    // MARK: - Setup

    override func setUpWithError() throws {
        sut = SearchStoreViewModel()
        
        sut.stores = [
            Store(
                id: 1,
                name: "First Store",
                logoImage: nil,
                headerImage: nil,
                location: "Location",
                stars: 5,
                products: [],
                specialties: ["pizza", "lanche"]
            ),
            Store(
                id: 2,
                name: "Second Store",
                logoImage: nil,
                headerImage: nil,
                location: "Location",
                stars: 3,
                products: [],
                specialties: ["sushi"]
            )
        ]
    }

    override func tearDownWithError() throws {
        
    }
    
    // MARK: - Unit Tests
    
    func testFilteredStores() {
        // When
        sut.searchText = "Se"
        
        // Than
        let filteredStores: [Store] = sut.filteredStores()
        XCTAssertEqual(1, filteredStores.count)
        XCTAssertEqual("Second Store", filteredStores.first?.name)
    }
    
    func testFileteredStoresWithSpecialCharacters() {
        // When
        sut.searchText = "#$%68K9)"
        
        // Than
        let filteredStores: [Store] = sut.filteredStores()
        XCTAssertEqual(0, filteredStores.count)
    }
    
    func testFilteredStoresBySpeialty() {
        // When
        sut.searchText = "Pizza"
        
        // Than
        let filteredStores: [Store] = sut.filteredStores()
        XCTAssertEqual(1, filteredStores.count)
        XCTAssertEqual("First Store", filteredStores.first?.name)
    }
}
