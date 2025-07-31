//
//  SearchServiceProtocol.swift
//  ChefDelivery
//
//  Created by Lucas de Castro Souza on 29/07/25.
//

/// Protocolo criado para facilitar o teste desse serviço, possibilitando a troca entre uma classe SearchService e MockSearchService
protocol SearchServiceProtocol {
    func fetchData() async throws -> Result<[Store], RequestError>
}
