//
//  HomeServiceProtocol.swift
//  ChefDelivery
//
//  Created by Lucas de Castro Souza on 29/07/25.
//

import Foundation

/// Protocolo criado para facilitar o teste desse serviço, possibilitando a troca entre uma classe HomeService e MockHomeService
protocol HomeServiceProtocol {
    func fetchData() async throws -> Result<[Store], RequestError>
    func confirmOrder(product: Product) async throws -> Result<[String: Any]?, RequestError>
    func fetchDataWithAlamofire(completion: @escaping ([Store]?, Error?) -> Void)
}
