//
//  SearchStoreViewModel.swift
//  ChefDelivery
//
//  Created by Lucas de Castro Souza on 29/07/25.
//

import Foundation

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
    
//    func fetchData() {
//        Task {
//            do {
//                let result = try await searchService.fetchData()
//                switch result {
//                case .success(let stores):
//                    self.stores = stores
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    func fetchData() {
        stores = Store.sample
    }
    
    func filteredStores() -> [Store] {
        if searchText.isEmpty {
            return stores
        } else {
            /// Array com as palavras digitadas na busca
            let searchTerms = searchText.lowercased().split(separator: " ")
            
            let filteredStores = stores.filter { store in
                
                ///Retorna true se todas as palavras digitadas na busca estiverem contidas no nome da Store
                let nameContainsSearchTerm = searchTerms.allSatisfy { term in
                    store.name.lowercased().contains(term)
                }
                
                /// Retorna true se todas as palavras digitadas na busca estiverem contidas nas specialties da Store
                let specialtiesContainsSearchTerm = searchTerms.allSatisfy { term in
                    store.specialties?.contains { $0.lowercased().contains(term) } ?? false
                }
                
                return nameContainsSearchTerm || specialtiesContainsSearchTerm
            }
            
            return filteredStores
        }
    }
}
