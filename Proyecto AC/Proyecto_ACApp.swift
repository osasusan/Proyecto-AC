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
    @State private var viewModel = LogViewModel()
    @State private var userVM = UserViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some Scene {
        WindowGroup {
            SplashView()
                .preferredColorScheme(.dark)
                .environment(vm)
                .environment(viewModel)
                .environment(userVM)
                
        }
    }
}
