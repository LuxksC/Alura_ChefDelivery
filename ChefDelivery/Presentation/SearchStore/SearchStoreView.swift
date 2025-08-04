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
                
                storesList
                
                Spacer()
            }
            .padding(.horizontal)
            .alert(Text("Desculpe!"), isPresented: $vm.showAlert) {} message: {
                Text("Ocorreu um erro em nosso servidor, nosso time está trabalhando para solucionar este problema.")
            }
        }
        .onAppear {
            vm.fetchData()
        }
    }
    
    @ViewBuilder
    var storesList: some View {
            List {
                if let stores = try? vm.filteredStores() {
                    ForEach(stores) { store in
                        Text(store.name)
                            .font(.custom("Futura", size: 16))
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 30)
                    }
                } else {
                    VStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.gray)
                            .padding(.top, 50)
                            .frame(height: 100)
                            .frame(maxWidth: .infinity)
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .padding(.top, 15)
            .listStyle(PlainListStyle())
            .scrollIndicators(.hidden)
    }
}

#Preview {
    SearchStoreView()
}

