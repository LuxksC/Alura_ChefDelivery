//
//  SearchStoreViewModel.swift
//  ChefDelivery
//
//  Created by Lucas de Castro Souza on 29/07/25.
//

import Foundation
import Combine

enum SearchError: Error {
    case noResultsFound
}

class SearchStoreViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var stores: [Store] = []
    @Published var showAlert: Bool = false
    
    private let searchService: SearchServiceProtocol
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(
        searService: SearchServiceProtocol = SearchService()
    ) {
        self.searchService = searService
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
                    self.showAlert = true
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
        
        let filteredStores: [Store] = stores.filter { $0.matches(query: searchText) }
        
        if filteredStores.isEmpty {
            throw SearchError.noResultsFound
        }
        
        return filteredStores
    }
}
