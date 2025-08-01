//
//  ArrayExtension.swift
//  ChefDelivery
//
//  Created by Lucas Souza on 30/07/25.
//

import Foundation

extension Array: Searchable where Element == String {
    func matches(query: String) -> Bool {
        contains(where: { $0.matches(query: query) })
    }
}
