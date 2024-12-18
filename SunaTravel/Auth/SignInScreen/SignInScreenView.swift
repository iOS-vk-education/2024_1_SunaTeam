//
//  SignInScreenView.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 18.12.2024.
//
import SwiftUI

struct SignInScreenView: View{
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            HeaderView(largeText: "Sign in now",
                       smallText: "Please sign in to continue our app")
            TextFieldView(text: "Email", isSecureField: false)
                .padding(.top, 40)
            TextFieldView(text: "Password", isSecureField: true)
            
            HStack {
                Spacer()
                ForgetPasswordButtonView()
            }
            
            Button {
                return Void()
            } label: {
                NavigationLink(destination: EmptyView()) {
                    Text("Sign in")
                }
                .buttonStyle(YellowButtonStyle())
                .padding(.top, 24)
            }
            .padding(.bottom, 40)
            
            SignUpPromptView()
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
    var body: some View {
        HStack {
            Text("Don't have an account")
                .font(.system(size: 14))
                .foregroundStyle(.secondary)
            Button {
                return Void()
            } label: {
                NavigationLink(destination: SignUpScreenView()) {
                    Text("Sign up")
                        .foregroundStyle(Color.blue)
                        .font(.system(size: 14))
                }
            }
        }
    }
}

#Preview {
    SignInScreenView()
}
