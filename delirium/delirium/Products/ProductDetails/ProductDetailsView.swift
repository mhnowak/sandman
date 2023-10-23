//
//  ProductDetailsView.swift
//  delirium
//
//  Created by Michał Nowak on 22/10/2023.
//

import SwiftUI

struct ProductDetailsView: View {
    @StateObject var viewModel: ProductDetailsViewModel
    var product: Product
    
    var body: some View {
        VStack {
            Text(product.title)
                .font(.title)
        }
        .padding()
        .navigationBarTitle("Product Details")
    }
    
}
