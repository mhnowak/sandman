//
//  ContentView.swift
//  delirium
//
//  Created by Michał Nowak on 22/10/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appCoordinator = AppCoordinator(path: NavigationPath())

    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.build().navigationDestination(for: ProductsFlowCoordinator.self) {
                coordinator in coordinator.build()
            }
        }               
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
