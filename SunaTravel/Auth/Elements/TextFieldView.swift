//
//  TextFieldView.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 18.12.2024.
//

import Foundation
import SwiftUI

struct TextFieldView: View {
    @State private var data = ""
    @State private var isSecure = false
    
    var text: String
    var isSecureField: Bool
    
    var body: some View {
        HStack {
            if isSecureField && isSecure {
                SecureField(text, text: $data)
            } else {
                TextField(text, text: $data)
            }
            
            if isSecureField {
                Button(action: {
                    isSecure.toggle()
                }) {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, minHeight: 56)
        .background(Color("TextFieldColor"))
        .cornerRadius(15)
        .padding(.bottom, 12)
    }
}
