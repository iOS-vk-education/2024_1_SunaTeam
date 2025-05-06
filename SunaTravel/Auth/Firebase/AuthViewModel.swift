//
//  AuthViewModel.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 24.02.2025.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isAuthenticated: Bool = false
    
    init() {
        checkAuthState()
    }
    
    func checkAuthState() {
        if let user = Auth.auth().currentUser {
            handleAuthenticatedUser(user)
        } else {
            handleUnauthenticatedUser()
        }
        
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let self = self else { return }
            
            if let user = user {
                handleAuthenticatedUser(user)
            } else {
                handleUnauthenticatedUser()
            }
        }
    }
    
    private func handleAuthenticatedUser(_ user: User) {
        if user.isEmailVerified {
            self.isAuthenticated = true
            print("User authenticated: \(user.uid)")
            
        } else {
            self.isAuthenticated = false
            try? Auth.auth().signOut()
        }
    }
    
    private func handleUnauthenticatedUser() {
        self.isAuthenticated = false
        print("User not authenticated")
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.isAuthenticated = false
        } catch {
        }
    }
    
    func register(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.user = authResult?.user
                }
                completion(true, nil)
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.user = authResult?.user
                    completion(true, nil)
                }
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
        } catch let error {
            print("Ошибка выхода: \(error.localizedDescription)")
        }
    }
    
    func resetPassword(email: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                completion(true, nil)
            }
        }
    }
}
