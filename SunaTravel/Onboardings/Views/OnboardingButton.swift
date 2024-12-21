//
//  OnboardingButton.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 14.12.2024.
//
import SwiftUI

struct OnboardingButton: View {
    let text: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.headline)
                .frame(maxWidth: .infinity, minHeight: OnboardingConstants.buttonMinHeight)
                .background(Color.accentBlue)
                .foregroundColor(Color.white)
                .cornerRadius(OnboardingConstants.buttonCornerRadius)
        }
    }
}
