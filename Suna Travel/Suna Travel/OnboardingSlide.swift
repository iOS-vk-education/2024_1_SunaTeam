//
//  OnboardingSlide.swift
//  Suna Travel
//
//  Created by Иван Тарасюк on 12.11.2024.
//

import SwiftUI

struct OnboardingSlide {
    let imageName: String      // Имя изображения, которое будет отображаться
    let title: String          // Заголовок экрана
    let subtitle: String       // Подзаголовок экрана
    let backgroundColor: Color // Цвет фона для экрана
}

let onboardingSlides = [
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
