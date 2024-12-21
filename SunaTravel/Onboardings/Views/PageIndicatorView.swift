//
//  PageIndicatorView.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 14.12.2024.
//
import SwiftUI

struct PageIndicatorView: View {
    let totalPages: Int
    let currentPage: Int

    var body: some View {
        HStack(spacing: OnboardingConstants.hStackSpacing) {
            ForEach(0..<totalPages, id: \.self) { index in
                if index == currentPage {
                    Capsule()
                        .fill(Color.accentBlue)
                        .frame(
                            width: OnboardingConstants.indicatorActiveWidth,
                            height: OnboardingConstants.indicatorHeight
                        )
                        .animation(.easeInOut(duration: OnboardingConstants.indicatorAnimationDuration), value: currentPage)
                } else {
                    Circle()
                        .fill(Color.accentBlue.opacity(OnboardingConstants.circleOpacity))
                        .frame(
                            width: OnboardingConstants.indicatorInactiveWidth,
                            height: OnboardingConstants.indicatorHeight
                        )
                        .animation(.easeInOut(duration: OnboardingConstants.indicatorAnimationDuration), value: currentPage)
                }
            }
        }
        .padding(.bottom, OnboardingConstants.buttonBottomPadding)
    }
}
