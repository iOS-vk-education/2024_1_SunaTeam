//
//  SecuredTextFieldView.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 17.03.2025.
//

import SwiftUI

struct SecuredTextFieldView: View {
    var text: String
    @Binding var textValue: String
    @State private var isPasswordVisible = false

    var body: some View {
        HStack {
            if !isPasswordVisible {
                TextField(text, text: $textValue)
                    .padding()
                    .background(Color.gray.opacity(0))
                    .cornerRadius(8)
            } else {
                SecureField(text, text: $textValue)
                    .padding()
                    .background(Color.gray.opacity(0))
                    .cornerRadius(8)
            }

            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 8)
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}
