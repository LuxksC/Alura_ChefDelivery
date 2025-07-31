//
//  CarouselItemView.swift
//  ChefDelivery
//
//  Created by ALURA on 18/05/23.
//

import SwiftUI

struct CarouselItemView: View {
    
    let order: Order
    
    var body: some View {
        Image(order.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(12)
    }
}

struct CarouselItemView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselItemView(order: Order(id: 1, name: "", image: "barbecue-banner"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
