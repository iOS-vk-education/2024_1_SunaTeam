//
//  SignUpScreenView.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 18.12.2024.
//

import Foundation
import SwiftUI

struct SignUpScreenView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var shouldHideBackButton = false
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    @State private var isNavigatingToHome = false
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(largeText: "Sign up now",
                           smallText: "Please fill the details and create an account")
                
                TextField("Name", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.top, 40)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                
                NavigationLink(destination: AppRootView(), isActive: $isNavigatingToHome) {
                    Button("Sign Up") {
                        authViewModel.register(email: email, password: password) { success, error in
                            if success {
                                presentationMode.wrappedValue.dismiss()
                                isNavigatingToHome = true
                                shouldHideBackButton = true
                            } else {
                                errorMessage = error
                            }
                        }
                    }
                    .buttonStyle(YellowButtonStyle())
                    .padding(.top, 24)
                }
                .padding(.bottom, 40)
                
                HStack {
                    Text("Already have an account")
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                    
                    Button("Sign in") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundStyle(Color.blue)
                    .font(.system(size: 14))
                }
            }
            .padding(.horizontal, 40)
            .navigationBarBackButtonHidden(shouldHideBackButton)
        }
    }
}
