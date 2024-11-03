//
//  SignUpScreenView.swift
//  SunaTeam
//
//  Created by Sergei Biryukov on 28.10.2024.
//

import Foundation
import SwiftUI

struct SignUpScreenView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            Spacer()
            VStack(alignment: .center) {
                HeaderView(largeText: "Sign up now",
                           smallText: "Please fill the details and create account")
                TextFieldView(text: "Name", isSecureField: false)
                    .padding(.top, 40)
                TextFieldView(text: "Email", isSecureField: false)
                TextFieldView(text: "Password", isSecureField: true)
            }
            .padding(.horizontal, 40)
            
            ButtonView(
                text: "Sign Up",
                width: 335,
                height: 56,
                backgroundColor: Color("ButtonColor2"),
                textColor: .white,
                paddingTop: 24,
                action: {
                    
                }
            )
            .padding(.bottom, 40)
            
            SignInPromptView()
                .padding(.horizontal, 8)
            Spacer()
        }
        .navigationBarItems(leading: Button(action: {
            // Возвращаемся к предыдущему экрану
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
        })
        .navigationBarBackButtonHidden(true)
    }
}

struct SignInPromptView: View {
    var body: some View {
        NavigationView {
            HStack {
                Text("Already have an account")
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
                Button {
                    return Void()
                } label: {
                    NavigationLink(destination: SignInScreenView()) {
                        Text("Sign in")
                            .foregroundStyle(Color("ButtonColor1"))
                            .font(.system(size: 14))
                    }
                }
            }
            
        }
    }
}

#Preview {
    SignUpScreenView()
}
