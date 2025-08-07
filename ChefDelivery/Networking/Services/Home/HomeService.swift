//
//  HomeService.swift
//  ChefDelivery
//
//  Created by ALURA on 30/06/23.
//

import Foundation
import Alamofire

enum RequestError: Error {
    case invalidURL
    case errorRequest(error: String)
    case serverError(statusCode: Int)
}

struct HomeService: HomeServiceProtocol {
    func fetchData() async throws -> Result<[Store], RequestError> {
        guard let url = URL(string: "https://private-665e5-matheusperez.apiary-mock.com/home") else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let storesObjects = try JSONDecoder().decode([Store].self, from: data)
        
        return .success(storesObjects)
    }
    
    func confirmOrder(product: Product) async throws -> Result<[String: Any]?, RequestError> {
        guard let url = URL(string: "https://private-665e5-matheusperez.apiary-mock.com/home") else {
            return .failure(.invalidURL)
        }
        
        let encodedObject = try JSONEncoder().encode(product)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = encodedObject
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let message = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        return .success(message)
    }
    
    func fetchDataWithAlamofire(completion: @escaping ([Store]?, Error?) -> Void) {
        AF.request("https://private-665e5-matheusperez.apiary-mock.com/home").responseDecodable(of: [Store].self) { response in
            switch response.result {
            case .success(let stores):
                completion(stores, nil)
            default: break
            }
        }
    }
}
