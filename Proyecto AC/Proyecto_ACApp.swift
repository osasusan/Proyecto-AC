//
//  Proyecto_ACApp.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 29/5/24.
//

import SwiftUI

@main
struct Proyecto_ACApp: App {
    @State private var vm = MangasViewModel()
    @State private var viewModel = LoginVeiwModel()
    var body: some Scene {
        WindowGroup {
            TabBar()
                .preferredColorScheme(.dark)
                .environment(vm)
                .environment(viewModel)
                
        }
    }
}
