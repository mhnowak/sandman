//
//  HomeView.swift
//  delirium
//
//  Created by Michał Nowak on 22/10/2023.
//

import SwiftUI
import Combine

struct ProductsListView: View {
    @StateObject var viewModel: ProductsListViewModel
    let didClickProduct = PassthroughSubject<Product, Never>()

    var body: some View {
        NavigationView {
            List(viewModel.products) { product in
                Button(action: {
                    didClickProduct.send(product)
                }) {
                    Text(product.title)
                }
            }
            .navigationBarTitle("Products")
            .onAppear {
                viewModel.fetchProducts()
            }
        }
    }
}

struct ProductsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsListView(viewModel: ProductsListViewModel())
    }
}
