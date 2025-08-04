//
//  SearchServiceStub.swift
//  ChefDelivery
//
//  Created by Lucas Souza on 04/08/25.
//

import Foundation

struct SearchServiceStub: SearchServiceProtocol {
    func fetchData() async throws -> Result<[Store], RequestError> {
        let stores: [Store] = [
            Store(id: 1,
                  name: "Monstro Burger",
                  logoImage: nil,
                  headerImage: nil,
                  location: "Rua Principal, 123, São Paulo, SP",
                  stars: 4,
                  products: [],
                  specialties: ["hamburguer", "lanchonete"]),
            Store(id: 2,
                  name: "Food Court",
                  logoImage: nil,
                  headerImage: nil,
                  location: "Avenida Secundária, 456, São Paulo, SP",
                  stars: 4,
                  products: [],
                  specialties: ["pizza", "lanchonete"])
        ]
        
        return .success(stores)
    }
}

struct SearchServiceStubFailure: SearchServiceProtocol {
    func fetchData() async throws -> Result<[Store], RequestError> {
        return .failure(RequestError.errorRequest(error: "Erro 500"))
    }
}
