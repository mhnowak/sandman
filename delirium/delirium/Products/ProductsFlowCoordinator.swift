//
//  ProductsFlowCoordinator.swift
//  delirium
//
//  Created by Michał Nowak on 22/10/2023.
//

import SwiftUI
import Combine

// Enum to identify User flow screen Types
enum ProductPage: String, Identifiable {
    case products, productDetails
    
    var id: String {
        self.rawValue
    }
}

final class ProductsFlowCoordinator: ObservableObject, Hashable {
    @Published var page: ProductPage
    
    private var id: UUID
    private var product: Product?
    private var cancellables = Set<AnyCancellable>()
    
    let pushCoordinator = PassthroughSubject<ProductsFlowCoordinator, Never>()
    
    init(page: ProductPage, product: Product? = nil) {
        id = UUID()
        self.page = page
        
        if page == .productDetails {
            guard let product = product else {
                fatalError("product must be provided for productDetails type")
            }
            self.product = product
        }
    }
    
    @ViewBuilder
    func build() -> some View {
        switch self.page {
        case .products:
            productsListView()
        case .productDetails:
            productDetailsView()
        }
    }
    
    // MARK: Required methods for class to conform to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ProductsFlowCoordinator, rhs: ProductsFlowCoordinator) -> Bool {
        return lhs.id == rhs.id
    }
    
    // MARK: View Creation Methods
    private func productsListView() -> some View {
        let viewModel = ProductsListViewModel()
        let productsListView = ProductsListView(viewModel: viewModel)
        bind(view: productsListView)
        return productsListView
    }
    
    private func productDetailsView() -> some View {
        let viewModel = ProductDetailsViewModel(productId: product!.id)
        let productDetailsView = ProductDetailsView(viewModel: viewModel, product: product!)
        return productDetailsView
    }
    
    // MARK: View Bindings
    private func bind(view: ProductsListView) {
        view.didClickProduct
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] product in
                self?.showProductDetails(for: product)
            })
            .store(in: &cancellables)
    }
}

// MARK: Navigation Related Extensions
extension ProductsFlowCoordinator {
    private func showProductDetails(for product: Product) {
        pushCoordinator.send(ProductsFlowCoordinator(page: .productDetails, product: product))
    }
}
