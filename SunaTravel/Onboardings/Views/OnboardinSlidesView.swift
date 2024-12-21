//
//  OnboardinSlidesView.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 14.12.2024.
//
import SwiftUI

struct OnboardingSlidesView: View {
    let slides: [OnboardingSlide]
    @Binding var currentPage: Int

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<slides.count, id: \.self) { index in
                OnboardingView(slide: slides[index])
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

