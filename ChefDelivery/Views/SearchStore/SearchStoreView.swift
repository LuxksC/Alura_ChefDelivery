//
//  SearchView.swift
//  ChefDelivery
//
//  Created by ALURA on 21/04/24.
//

import SwiftUI

struct SearchStoreView: View {
    
    let service: SearchService
    @State var storesType: [StoreType] = []
    
    // MARK: - Main View
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(storesType, id: \.id) { store in
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
        }
        .onAppear {
            fetchData()
        }
    }
    
    // MARK: - Class methods
    
    func fetchData() {
        Task {
            do {
                let result = try await service.fetchData()
                switch result {
                case .success(let stores):
                    self.storesType = stores
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

