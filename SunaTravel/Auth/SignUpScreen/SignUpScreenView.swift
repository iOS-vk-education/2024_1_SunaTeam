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
    var body: some View {
        VStack {
            HeaderView(largeText: "Sign up now",
                       smallText: "Please fill the details and create account")
            TextFieldView(text: "Name", isSecureField: false)
                .padding(.top, 40)
            TextFieldView(text: "Email", isSecureField: false)
            TextFieldView(text: "Password", isSecureField: true)
            
            Button {
                return Void()
            } label: {
                NavigationLink(destination: EmptyView()) {
                    Text("Sign Up")
                }
                .buttonStyle(YellowButtonStyle())
                .padding(.top, 24)
            }
            .padding(.bottom, 40)
            
            HStack {
                Text("Already have an account")
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
                Button {
                    return Void()
                } label: {
                    NavigationLink(destination: SignInScreenView()) {
                        Text("Sign in")
                            .foregroundStyle(Color.blue)
                            .font(.system(size: 14))
                    }
                }
            }
        }
        .padding(.horizontal, 40)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.secondary)
        })
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SignUpScreenView()
}
