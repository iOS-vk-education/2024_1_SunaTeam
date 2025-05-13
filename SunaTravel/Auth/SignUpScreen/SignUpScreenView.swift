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
    @EnvironmentObject var settings: AppSettings
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    
    private let profileViewModel = AppState.shared.profileViewModel
    
    var body: some View {
        VStack {
            HeaderView(largeText: SignUpText.title(for: settings.currentLanguage),
                       smallText: SignUpText.text(for: settings.currentLanguage))
            
            TextFieldView(text: SignUpText.name(for: settings.currentLanguage), isSecureField: false, textValue: $name)
                .padding(.top, 10)
                .cornerRadius(8)
            TextFieldView(text: SignUpText.email(for: settings.currentLanguage), isSecureField: false, textValue: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding(.top, 10)
                .cornerRadius(8)
            SecuredTextFieldView(text: SignUpText.password(for: settings.currentLanguage), textValue: $password)
                .padding(.top, 10)
                .cornerRadius(8)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            Button(SignUpText.signup(for: settings.currentLanguage)) {
                authViewModel.register(email: email, password: password) { success, error in
                    if success {
                        profileViewModel.saveChanges(name: name, email: email, location: "", phoneNumber: "", avatar: nil)
                    } else {
                        errorMessage = error
                    }
                }
            }
            .buttonStyle(YellowButtonStyle())
            .padding(.top, 24)
            .padding(.bottom, 10)
            
            HStack {
                Text(SignUpText.already(for: settings.currentLanguage))
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
                
                NavigationLink(SignUpText.signin(for: settings.currentLanguage)) {
                    SignInScreenView()
                }
                .foregroundStyle(Color.blue)
                .font(.system(size: 14))
            }
        }
        .padding(.horizontal, 40)
        .navigationTitle(SignUpText.signup(for: settings.currentLanguage))
        .navigationBarTitleDisplayMode(.inline)
    }
}
