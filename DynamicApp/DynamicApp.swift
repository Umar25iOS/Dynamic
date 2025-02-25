//
//  DynamicApp.swift
//  DynamicApp
//
//  Created by Mohammad Khan on 11/02/25.
//

import SwiftUI

@main
struct DynamicAppApp: App {
    @StateObject private var loginViewModel = LoginViewModel()  // Initialize LoginViewModel

    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: loginViewModel)  // Pass the viewModel to LoginView
        }
    }
}
