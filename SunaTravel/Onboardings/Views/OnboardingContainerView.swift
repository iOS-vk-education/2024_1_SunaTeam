//
//  File.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 13.12.2024.
//

import SwiftUI

struct OnboardingConstants {
    static let buttonMinHeight: CGFloat = 50
    static let buttonHorizontalPadding: CGFloat = 20
    static let buttonBottomPadding: CGFloat = 20
    static let indicatorActiveWidth: CGFloat = 35
    static let indicatorHeight: CGFloat = 8
    static let indicatorInactiveWidth: CGFloat = 8
    static let indicatorAnimationDuration: Double = 0.3
    static let buttonAnimationDuration: Double = 0.5
    static let hStackSpacing: CGFloat = 8
    static let circleOpacity: Double = 0.3
    static let buttonCornerRadius: CGFloat = 10
    static let buttonSkipCornerRadius: CGFloat = 8
    static let buttonSkipBackgroundOpacity: Double = 0.4
}

struct OnboardingContainerView: View {
    @Binding var isFirstLaunch: Bool
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                OnboardingSlidesView(slides: viewModel.onboardingSlides, currentPage: $viewModel.currentPage)
                    .ignoresSafeArea(.all)
                
                PageIndicatorView(totalPages: viewModel.onboardingSlides.count, currentPage: viewModel.currentPage)
                
                OnboardingButton(text: viewModel.buttonText) {
                    withAnimation(.easeInOut(duration: OnboardingConstants.buttonAnimationDuration)) {
                        if viewModel.currentPage < viewModel.onboardingSlides.count - 1 {
                            viewModel.nextPage()
                        } else {
                            isFirstLaunch = false
                        }
                    }
                }
                .padding(.horizontal, OnboardingConstants.buttonHorizontalPadding)
                .padding(.bottom, OnboardingConstants.buttonBottomPadding)
            }
            .background(Color.white)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    OnboardingToolbar(isFirstLaunch: $isFirstLaunch)
                }
            }
        }
    }
}
