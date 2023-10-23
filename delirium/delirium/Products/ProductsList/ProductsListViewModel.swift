//
//  ProductsListViewModel.swift
//  delirium
//
//  Created by Michał Nowak on 22/10/2023.
//

import Combine

final class ProductsListViewModel: ObservableObject {
    @Published var products: [Product] = []
    
    func fetchProducts() {
        self.products = [
            Product(id: 1, title: "Product 1", description: "Description", imageUrl: "https://images.unsplash.com/photo-1495194757773-40c27034b638"),
            Product(id: 2, title: "Product 2", description: "Description", imageUrl: "https://images.unsplash.com/photo-1495194757773-40c27034b638"),
            Product(id: 3, title: "Product 3", description: "Description", imageUrl: "https://images.unsplash.com/photo-1495194757773-40c27034b638"),
        ]
    }
}
