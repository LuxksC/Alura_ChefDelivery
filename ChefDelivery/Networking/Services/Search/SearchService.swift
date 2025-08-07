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
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                return .failure(.serverError(statusCode: httpResponse.statusCode))
            }
            
            let stores = try JSONDecoder().decode([Store].self, from: data)
            return .success(stores)
        } catch {
            return .failure(.errorRequest(error: error.localizedDescription))
        }
    }
    
}
