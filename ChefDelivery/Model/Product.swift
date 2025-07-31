//
//  ProductType.swift
//  ChefDelivery
//
//  Created by Giovanna Moeller on 03/06/23.
//

import Foundation
import SwiftAndTipsMacros
import DataGenerator

@SampleBuilder(numberOfItems: 3, dataGeneratorType: .random)
struct Product: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let image: String
    @SampleBuilderItem(category: .price)
    let price: Double

    var formattedPrice: String {
    return "R$ " + price.formatPrice()
    }
}
