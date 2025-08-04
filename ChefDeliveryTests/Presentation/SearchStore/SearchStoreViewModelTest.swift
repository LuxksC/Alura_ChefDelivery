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
        var searchServiceStub = SearchServiceStub()
        sut = SearchStoreViewModel(searService: searchServiceStub)
        
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
        var filteredStores: [Store] = []
        
        do {
            filteredStores = try sut.filteredStores()
            XCTAssertEqual(1, filteredStores.count)
            XCTAssertEqual("Second Store", filteredStores.first?.name)
        } catch {
            XCTFail("Failure in testFilteredStores")
        }
    }
    
    func testFileteredStoresWithSpecialCharacters() {
        // When
        sut.searchText = "#$%68K9)"
        
        // Than
        var filteredStores: [Store] = []
        
        do {
            filteredStores = try sut.filteredStores()
            XCTFail("Failure in testFileteredStoresWithSpecialCharacters")
        } catch {
            XCTAssertEqual(0, filteredStores.count)
        }
    }
    
    func testFilteredStoresBySpeialty() {
        // When
        sut.searchText = "Pizza"
        
        // Than
        var filteredStores: [Store] = []
        
        do {
            filteredStores = try sut.filteredStores()
            XCTAssertEqual(1, filteredStores.count)
            XCTAssertEqual("First Store", filteredStores.first?.name)
        } catch {
            XCTFail("Failure in testFilteredStoresBySpeialty")
        }
    }
    
    func testFilteredStoresException() {
        sut.searchText = "zzAACF"
        
        XCTAssertThrowsError(try sut.filteredStores())
    }
    
    func testFetchDataWithSuccess() {
        let stub = SearchServiceStub()
        sut = SearchStoreViewModel(searService: stub)
        
        let expectation = XCTestExpectation(description: "Fetch stores list")
        
        sut
            .$stores // observa a variável stores
            .dropFirst() // ignora o primeiro valor atribuído a variável, no caso é o valor de inicialização dela
            .sink { stores in // executa uma ação toda vez que o valor da variável é alterado
                XCTAssertEqual(2, stores.count)
                XCTAssertEqual("Monstro Burger", stores[0].name)
                XCTAssertEqual("Food Court", stores[1].name)
                
                expectation.fulfill()
            }
            .store(in: &sut.cancellables) // cancela a observação de alterações da variável
        
        sut.fetchData()
        
        wait(for: [expectation], timeout: 1) // espera um segundo para executar o teste
    }
    
    func testFetchDataWithFailure() {
        let stub = SearchServiceStubFailure()
        sut = SearchStoreViewModel(searService: stub)
        
        let expectation = XCTestExpectation(description: "Show error alert")
        
        sut
            .$showAlert
            .dropFirst()
            .sink { showAlert in
                XCTAssertTrue(showAlert)
                expectation.fulfill()
            }
            .store(in: &sut.cancellables)
        
        sut.fetchData()
        
        wait(for: [expectation], timeout: 1)
    }
}


