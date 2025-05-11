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
    
    private var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        checkAuthState()
    }
    
    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func checkAuthState() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let user = user, user.isEmailVerified {
                    self.user = user
                    self.isAuthenticated = true
                    print("User authenticated: \(user.uid)")
                } else {
                    self.user = nil
                    self.isAuthenticated = false
                    print("User not authenticated")
                }
            }
        }
    }
    
    private func handleAuthenticatedUser(_ user: User) {
        DispatchQueue.main.async {
            self.user = user
            self.isAuthenticated = true
            print("User authenticated: \(user.uid)")
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
