//
//  SignInScreenView.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 18.12.2024.
//
import SwiftUI
import Firebase

struct SignInScreenView: View{
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    @State private var isSignedIn = false
    var body: some View {
        NavigationView{
            VStack {
                HeaderView(largeText: "Sign in now",
                           smallText: "Please sign in to continue our app")
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.top, 40)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                HStack {
                    Spacer()
                    Button("Forget Password?") {
                        authViewModel.resetPassword(email: email) { success, error in
                        }
                    }
                    .foregroundStyle(Color.blue)
                    .font(.system(size: 14))
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
                    //if login == nnn { ...
                }
                .padding(.bottom, 40)
                
                SignUpPromptView()
            }
            .padding(.horizontal, 40)
        }
    }
    
    struct ForgetPasswordButtonView: View {
        var body: some View {
            Button {
                return Void()
            } label: {
                Text("Forget Password?")
                    .foregroundStyle(Color.blue)
                    .font(.system(size: 14))
            }
        }
    }
    
    struct SignUpPromptView: View {
        @State private var isNavigating = false
        var body: some View {
            HStack {
                Text("Don't have an account")
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
}
