//
//  Store.swift
//  ChefDelivery
//
//  Created by Giovanna Moeller on 03/06/23.
//

import Foundation
import SwiftAndTipsMacros
import DataGenerator

protocol Searchable {
    func matches(query: String) -> Bool
}

@SampleBuilder(numberOfItems: 5, dataGeneratorType: .random)
struct Store: Identifiable, Codable {
    let id: Int
    @SampleBuilderItem(category: .companyName)
    let name: String
    let logoImage: String?
    let headerImage: String?
    @SampleBuilderItem(category: .address)
    let location: String
    let stars: Int
    let products: [Product]?
    let specialties: [String]?
    
    init(id: Int, name: String, logoImage: String?, headerImage: String?, location: String, stars: Int, products: [Product]?, specialties: [String]? = []) {
        self.id = id
        self.name = name
        self.logoImage = logoImage
        self.headerImage = headerImage
        self.location = location
        self.stars = stars
        self.products = products
        self.specialties = specialties
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, name, location, stars, products, specialties
        case logoImage = "logo_image"
        case headerImage = "header_image"
    }
}

extension Store: Searchable {
    func matches(query: String) -> Bool {
        var parameters: [Searchable]
        
        if let specialties, !specialties.isEmpty {
            parameters = [name, specialties]
        } else {
            parameters = [name]
        }
        
        return parameters.contains(where: { $0.matches(query: query.lowercased()) })
    }
}
