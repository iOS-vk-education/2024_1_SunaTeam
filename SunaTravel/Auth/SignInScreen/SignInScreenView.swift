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
                    .padding(.top, 40)
                
                TextFieldView(text: "Password", isSecureField: true, textValue: $password)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 5)
                }
                
                HStack {
                    Spacer()
                    ForgetPasswordButtonView(email: email)
                }
                
                Button {
                    authViewModel.login(email: email, password: password) { success, error in
                        if success {
                            isSignedIn = true
                        } else {
                            errorMessage = error
                        }
                    }
                } label: {
                    NavigationLink(destination: AppRootView(), isActive: $isSignedIn) {
                        Text("Sign in")
                    }
                    .buttonStyle(YellowButtonStyle())
                    .padding(.top, 24)
                }
                .padding(.bottom, 40)
                
                SignUpPromptView()
            }
            .padding(.horizontal, 40)
            .keyboardAdaptive() // ✅ Двигает контент при появлении клавиатуры
        }
        .navigationViewStyle(.stack)
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
            }
        }
    }
}
