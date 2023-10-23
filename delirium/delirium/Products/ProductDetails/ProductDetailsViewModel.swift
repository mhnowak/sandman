//
//  ProductDetailsViewModel.swift
//  delirium
//
//  Created by Michał Nowak on 22/10/2023.
//

import Combine

final class ProductDetailsViewModel: ObservableObject {
    private var productId: Int
    
    init(productId: Int) {
        self.productId = productId
    }
}
