//
//  ProfileInputView.swift
//  Suna Travel
//
//  Created by salfetka on 26.11.2024.
//

import Foundation
import SwiftUI

struct ProfileInputField: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
            TextField(title, text: $text)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
        }
    }
}
