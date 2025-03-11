//
//  TextFieldView.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 18.12.2024.
//

import Foundation
import SwiftUI

struct TextFieldView: View {
    var text: String
    var isSecureField: Bool
    @Binding var textValue: String

    var body: some View {
        if isSecureField {
            TextField(text, text: $textValue)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        } else {
            TextField(text, text: $textValue)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
    }
}
