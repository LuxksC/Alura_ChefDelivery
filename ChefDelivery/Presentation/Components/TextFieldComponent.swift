//
//  TextFieldComponent.swift
//  ChefDelivery
//
//  Created by Lucas de Castro Souza on 29/07/25.
//

import SwiftUI

struct TextFieldComponent: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(.systemGray))
            
            TextField("Pesquisar...", text: $text)
                .foregroundColor(Color(.darkGray))
            
            if !text.isEmpty {
                Button(action: {
                    cleanText()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(.systemGray))
                })
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
    private func cleanText() {
        text = ""
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TextFieldComponent(text: .constant("Search Text"))
}
