//
//  OnboardingToolbar.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 14.12.2024.
//
import SwiftUI

struct OnboardingToolbar: View {
    @Binding var isFirstLaunch: Bool

    var body: some View {
        Button(action: {
            isFirstLaunch = false
        }) {
            Text("Skip")
                .font(.headline)
                .foregroundColor(Color.gray)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.gray.opacity(OnboardingConstants.buttonSkipBackgroundOpacity))
                .cornerRadius(OnboardingConstants.buttonSkipCornerRadius)
        }
    }
}
