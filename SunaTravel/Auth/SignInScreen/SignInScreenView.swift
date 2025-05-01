//
//  SignInScreenView.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 18.12.2024.
//
import SwiftUI
import Firebase

struct SignInScreenView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    @State private var isSignedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(largeText: "Sign in now",
                           smallText: "Please sign in to continue our app")
                
                TextFieldView(text: "Email", isSecureField: false, textValue: $email)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                
                SecuredTextFieldView(text: "Password", textValue: $password)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
                
                HStack {
                    Spacer()
                    ForgetPasswordButtonView(email: email)
                }
                
                Button(action: handleSignIn) {
                    Text("Sign in")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                
                SignUpPromptView()
            }
            .padding(.horizontal, 40)
            .keyboardAdaptive()
            .fullScreenCover(isPresented: $isSignedIn) {
                AppRootView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func handleSignIn() {
        guard isValidEmail(email) else {
            errorMessage = "Invalid email format"
            return
        }
        
        guard !password.isEmpty else {
            errorMessage = "Password cannot be empty"
            return
        }
        
        authViewModel.login(email: email, password: password) { success, error in
            if success {
                isSignedIn = true
            } else {
                errorMessage = error ?? "An unknown error occurred"
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }
}

struct ForgetPasswordButtonView: View {
    var email: String
    
    var body: some View {
        Button("Forget Password?") {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    print("Error resetting password: \(error.localizedDescription)")
                } else {
                    print("Password reset email sent successfully")
                }
            }
        }
        .foregroundStyle(Color.blue)
        .font(.system(size: 14))
        .padding(.top, 8)
        .padding(.bottom, 8)
    }
}

struct SignUpPromptView: View {
    @State private var isNavigating = false
    
    var body: some View {
        HStack {
            Text("Don't have an account?")
                .font(.system(size: 14))
                .foregroundStyle(.secondary)
            NavigationLink(destination: SignUpScreenView(),
                           isActive: $isNavigating) {
                Text("Sign up")
                    .foregroundStyle(Color.blue)
                    .font(.system(size: 14))
                    .padding(.top, 8)
            }
        }
    }
}
