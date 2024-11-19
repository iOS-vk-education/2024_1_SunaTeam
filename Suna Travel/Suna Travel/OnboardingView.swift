//
//  OnboardingView.swift
//  Suna Travel
//
//  Created by Иван Тарасюк on 12.11.2024.
//

import SwiftUI

struct OnboardingView: View {
    let slide: OnboardingSlide // Модель данных для слайда

    var body: some View {
        VStack {
            Image(slide.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.53)
            
            // Создаем AttributedString для заголовка
            if let attributedTitle = createAttributedTitle(from: slide.title) {
                Text(attributedTitle)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
            }
            
            BrushStrokeView()
                .frame(width: 80, height: 1)
                .foregroundColor(.deepOrange)
                .padding(.leading, 40)
            
            Text(slide.subtitle)
                .font(.system(size: 20, weight: .medium, design: .serif))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.top, 10)

            Spacer()
        }
        .background(slide.backgroundColor)
        .edgesIgnoringSafeArea(.all)
    }
}

extension Color {
    static let deepOrange = Color(red: 1.0, green: 0.45, blue: 0.0) // Более яркий оранжевый
}


struct BrushStrokeView: View {
    var body: some View {
        ZStack {
            // Вытянутый оранжевый овал
            Ellipse()
                .fill(Color.deepOrange)
                .frame(width: 110, height: 85) // Размер овала
                .offset(y: 25)
            
            Ellipse()
                .fill(Color.white)
                .frame(width: 118, height: 80) // Размер овала
                .offset(y: 28)
        }
        .frame(height: 20) // Ограничиваем общую высоту фигуры
    }
}


// Вспомогательная функция для создания AttributedString
func createAttributedTitle(from title: String) -> AttributedString? {
    var attributedString = AttributedString(title)
    
    // Ищем последнее слово и меняем его цвет
    if let lastSpaceIndex = attributedString.characters.lastIndex(of: " ") {
        let range = attributedString.characters.index(after: lastSpaceIndex)..<attributedString.endIndex
        attributedString[range].foregroundColor = .deepOrange
    }
    return attributedString
}
