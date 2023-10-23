//
//  CoordinatorApp.swift
//  delirium
//
//  Created by Michał Nowak on 22/10/2023.
//

//
//  AppCoordinator.swift
//  delirium
//
//  Created by Michał Nowak on 22/10/2023.
//

import SwiftUI
import Combine

final class AppCoordinator: ObservableObject {
    @Published var path: NavigationPath
    private var cancellables = Set<AnyCancellable>()
    
    init(path: NavigationPath) {
        self.path = path
    }
    
    @ViewBuilder
    func build() -> some View {
        EmptyView().onAppear {
            self.productsFlow()
        }
    }
    
    private func push<T: Hashable>(_ coordinator: T) {
        path.append(coordinator)
    }
            
    // MARK: Flow Control Methods
    private func productsFlow() {
        let productsFlowCoordinator = ProductsFlowCoordinator(page: .products)
        self.bind(productsCoordinator: productsFlowCoordinator)
        self.push(productsFlowCoordinator)
    }
        
    // MARK: Flow Coordinator Bindings
    private func bind(productsCoordinator: ProductsFlowCoordinator) {
        productsCoordinator.pushCoordinator
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] coordinator in
                self?.push(coordinator)
            })
            .store(in: &cancellables)
    }

}
