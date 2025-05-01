//
//  View+KeyboardAdaptive.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 11.03.2025.
//

import SwiftUI
import Combine

struct KeyboardAdaptive: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .animation(.easeOut(duration: 0.3), value: keyboardHeight)
            .onReceive(Publishers.keyboardHeight) { height in
                self.keyboardHeight = height
            }
    }
}

extension View {
    func keyboardAdaptive() -> some View {
        self.modifier(KeyboardAdaptive())
    }
}

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { notification -> CGFloat? in
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height
            }

        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        return willShow.merge(with: willHide)
            .eraseToAnyPublisher()
    }
}
