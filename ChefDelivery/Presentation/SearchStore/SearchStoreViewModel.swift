//
//  SearchStoreViewModel.swift
//  ChefDelivery
//
//  Created by Lucas de Castro Souza on 29/07/25.
//

import Foundation

enum SearchError: Error {
    case noResultsFound
}

class SearchStoreViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var stores: [Store] = []
    
    
    private let searchService: SearchServiceProtocol
    
    // MARK: - Init
    
    init(
        searService: SearchServiceProtocol = SearchService()
    ) {
        self.searchService = searService
        fetchData()
    }
    
    // MARK: - Public Methods
    
    func fetchData() {
        Task {
            do {
                let result = try await searchService.fetchData()
                switch result {
                case .success(let stores):
                    self.stores = stores
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func filteredStores() throws -> [Store] {
        if searchText.isEmpty {
            return stores
        }
        
        let filteredStores: [Store] = try stores.filter { $0.matches(query: searchText) }
        
        if filteredStores.isEmpty {
            throw SearchError.noResultsFound
        }
        
        return filteredStores
    }
}
