//
//  SearchView.swift
//  ChefDelivery
//
//  Created by ALURA on 21/04/24.
//

import SwiftUI

struct SearchStoreView: View {
    @StateObject var vm: SearchStoreViewModel = SearchStoreViewModel()
    
    // MARK: - Main View
    
    var body: some View {
        NavigationView {
            VStack {
                TextFieldComponent(text: $vm.searchText)
                
                List {
                    ForEach(vm.filteredStores()) { store in
                        Text(store.name)
                            .font(.custom("Futura", size: 16))
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 30)
                    }
                }
                .padding(.top, 15)
                .listStyle(PlainListStyle())
                .scrollIndicators(.hidden)
                
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    SearchStoreView()
}

