//
//  HeaderView.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 18.12.2024.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    var largeText: String
    var smallText: String?
    var body: some View {
        Text(largeText)
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .fontWeight(.semibold)
            .padding(.bottom, 2)
        
        Text(smallText ?? "")
            .font(.body)
            .fontWeight(.regular)
            .foregroundStyle(.secondary)
    }
}
