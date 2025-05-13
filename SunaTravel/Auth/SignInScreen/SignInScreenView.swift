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
    @EnvironmentObject var settings: AppSettings
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    @State private var isSignedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(largeText: SignInText.title(for: settings.currentLanguage),
                           smallText: SignInText.text(for: settings.currentLanguage))
                
                TextFieldView(text: SignInText.email(for: settings.currentLanguage), isSecureField: false, textValue: $email)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                
                SecuredTextFieldView(text: SignInText.password(for: settings.currentLanguage), textValue: $password)
                
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
                    Text(SignInText.signin(for: settings.currentLanguage))
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
            errorMessage = SignInText.invalidEmail(for: settings.currentLanguage)
            return
        }
        
        guard !password.isEmpty else {
            errorMessage = SignInText.invalidPassword(for: settings.currentLanguage)
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
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        Button(SignInText.forget(for: settings.currentLanguage)) {
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
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        HStack {
            Text(SignInText.dont(for: settings.currentLanguage))
                .font(.system(size: 14))
                .foregroundStyle(.secondary)
            NavigationLink(destination: SignUpScreenView(),
                           isActive: $isNavigating) {
                Text(SignInText.signup(for: settings.currentLanguage))
                    .foregroundStyle(Color.blue)
                    .font(.system(size: 14))
                    .padding(.top, 8)
            }
        }
    }
}
