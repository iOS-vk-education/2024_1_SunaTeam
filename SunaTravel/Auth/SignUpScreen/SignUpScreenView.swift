//
//  SignUpScreenView.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 18.12.2024.
//

import Foundation
import SwiftUI

struct SignUpScreenView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            HeaderView(largeText: "Sign up now",
                       smallText: "Please fill the details and create an account")
            
            TextFieldView(text: "Name", isSecureField: false, textValue: $name)
                .padding(.top, 10)
                .cornerRadius(8)
            TextFieldView(text: "Email", isSecureField: false, textValue: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding(.top, 10)
                .cornerRadius(8)
            SecuredTextFieldView(text: "Password", textValue: $password)
                .padding(.top, 10)
                .cornerRadius(8)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            Button("Sign Up") {
                authViewModel.register(email: email, password: password) { success, error in
                    if success {
                    } else {
                        errorMessage = error
                    }
                }
            }
            .buttonStyle(YellowButtonStyle())
            .padding(.top, 24)
            .padding(.bottom, 10)
            
            HStack {
                Text("Already have an account")
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
                
                NavigationLink("Sign in") {
                    SignInScreenView()
                }
                .foregroundStyle(Color.blue)
                .font(.system(size: 14))
            }
        }
        .padding(.horizontal, 40)
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
    }
}
