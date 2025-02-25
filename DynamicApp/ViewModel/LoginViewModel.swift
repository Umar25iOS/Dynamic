//
//  LoginViewModel.swift
//  DynamicApp
//
//  Created by Mohammad Khan on 11/02/25.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    //MARK: Properties and Variables
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoginValid: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isLoggedIn: Bool = false  // Add this property

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Observing email and password changes
        $email.combineLatest($password)
            .map { email, password in
                return self.isValidEmail(email) && self.isValidPassword(password)
            }
            .assign(to: \.isLoginValid, on: self)
            .store(in: &cancellables)
    }

    //MARK: Validate Email
    private func isValidEmail(_ email: String) -> Bool {
        // Regex for email validation
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    //MARK: Validate Password
    private func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8 && password.count <= 15
    }

    //MARK: Perform Login Action
    func login() {
        // Save user data to Realm (for demo purpose, use Post model)
        let user = Post()
        user.title = email
        user.body = password
        RealmManager.shared.save(post: user)

        // Set the logged-in state to true
        isLoggedIn = true
    }
}
