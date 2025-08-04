//
//  SearchService.swift
//  ChefDelivery
//
//  Created by Ândriu F Coelho on 21/04/24.
//

import Foundation

struct SearchService: SearchServiceProtocol {
    
    func fetchData() async throws -> Result<[Store], RequestError> {
        guard let url = URL(string: "https://private-747f3d-lucasdecastro.apiary-mock.com/search") else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let storesObjects = try JSONDecoder().decode([Store].self, from: data)
        
        return .success(storesObjects)
    }
    
}
