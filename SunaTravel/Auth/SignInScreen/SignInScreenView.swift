//
//  SignInScreenView.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 18.12.2024.
//
import SwiftUI

struct SignInScreenView: View{
    @Environment(\.presentationMode) var presentationMode
    @State private var isSignedIn = false
    var body: some View {
        NavigationView{
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
