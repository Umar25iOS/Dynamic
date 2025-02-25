//
//  LoginView.swift
//  DynamicApp
//
//  Created by Mohammad Khan on 11/02/25.
//
import SwiftUI

struct LoginView: View {
    
    //MARK: Properties and Variables
    @ObservedObject var viewModel: LoginViewModel
    @State private var navigateToHome = false  // A state to control navigation

    //MARK: Body
    var body: some View {
        NavigationView {
            VStack {
                TextField(StringConstant.email, text: $viewModel.email)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField(StringConstant.password, text: $viewModel.password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    viewModel.login()
                    navigateToHome = true  // Set to true to trigger navigation after login
                }) {
                    Text(StringConstant.login)
                        .foregroundColor(.white)
                        .padding()
                        .background(viewModel.isLoginValid ? Color.blue : Color.gray)
                        .cornerRadius(10)
                }
                .disabled(!viewModel.isLoginValid)

                if viewModel.isLoggedIn {
                    Text("\(StringConstant.welcome), \(viewModel.email)")
                        .foregroundColor(.green)
                        .padding()
                }

                // The navigation logic
                NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                    EmptyView()  // Invisible link that triggers navigation
                }
            }
            .padding()
        }
    }
}
