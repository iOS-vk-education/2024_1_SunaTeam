//
//  OnboardingViewModel.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 13.12.2024.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var currentPage: Int = 0
    
    var onboardingSlides = [
        OnboardingSlide(
            imageName: "firstBoard",
            title: "Life is short and the world is wide",
            subtitle: "At Suna Travel, we customize reliable and trustworthy educational tours to destinations all over the world",
            backgroundColor: Color.white
        ),
        OnboardingSlide(
            imageName: "secondBoard",
            title: "It's a big world out there go explore",
            subtitle: "To get the best of your adventure you just need to leave and go where you like. We are waiting for you",
            backgroundColor: Color.white
        )
    ]
//    init(OnboardingSlides: [OnboardingSlide]) {
//        self.onboardingSlides = OnboardingSlides
//    }
    
    var buttonText: String {
        currentPage == onboardingSlides.count - 1 ? "Get Started" : "Next"
    }
    
    func nextPage() {
        if currentPage < onboardingSlides.count - 1 {
            currentPage += 1
        }
    }
}
