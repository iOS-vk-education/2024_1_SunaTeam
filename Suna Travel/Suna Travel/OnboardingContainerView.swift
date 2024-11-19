//
//  OnboardingContainerView.swift
//  Suna Travel
//
//  Created by Иван Тарасюк on 12.11.2024.
//

import SwiftUI

extension Color {
    static let customBlue = Color(red: 0x24 / 255.0, green: 0xBA / 255.0, blue: 0xEC / 255.0)
}

struct OnboardingContainerView: View {
    @Binding var isFirstLaunch: Bool // Привязка для обновления состояния первого запуска
    @State private var currentPage = 0 // Переменная для отслеживания текущего слайда
    let slides = onboardingSlides      // Массив данных для слайдов
    let totalPages = onboardingSlides.count

    var body: some View {
            NavigationView{
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0..<slides.count) { index in
                        OnboardingView(slide: slides[index]) // Отображаем каждый слайд
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Отключаем стандартный индикатор
                .ignoresSafeArea(.all)
                
                
                HStack(spacing: 8) {
                            ForEach(0..<totalPages, id: \.self) { index in
                                if index == currentPage {
                                    // Активный индикатор
                                    Capsule()
                                        .fill(Color.customBlue)
                                        .frame(width: 35, height: 8) // Длина и высота активного индикатора
                                        .animation(.easeInOut(duration: 0.3), value: currentPage) // Анимация
                                } else {
                                    // Неактивные индикаторы
                                    Circle()
                                        .fill(Color.customBlue.opacity(0.3))
                                        .frame(width: 8, height: 8) // Размер неактивных индикаторов
                                        .animation(.easeInOut(duration: 0.3), value: currentPage) // Анимация
                                }
                            }
                            .padding(.bottom, 40)
                    }
                
  
                
                // Кнопка для завершения онбординга
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) { // Анимация для перехода к следующему слайду
                        if currentPage < slides.count - 1 {
                            // Переход к следующему слайду
                            currentPage += 1
                        } else {
                            //Завершение онбординга, действие для "Get Started"
                            isFirstLaunch = false // Логика завершения онбординга
                            //Код для перехода к основному экрану 
                        }
                    }
                }) {
                    Text(currentPage == slides.count - 1 ? "Get Started" : "Next")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.customBlue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                }
            }
            .background(Color.white)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Действие для пропуска онбординга
                        isFirstLaunch = false
                    }) {
                        Text("Skip")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}
