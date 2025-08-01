//
//  StringExtension.swift
//  ChefDelivery
//
//  Created by Lucas Souza on 30/07/25.
//

import Foundation

extension String: Searchable {
    func matches(query: String) -> Bool {
        return lowercased().contains(query.lowercased())
    }
}
