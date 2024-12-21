//
//  OnboardingViewController.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 13.12.2024.
//

import UIKit
import SwiftUI

struct OnboardingViewController: View {
    var onFinish: () -> Void
    
    var body: some View {
        Button("Get Started") {
            onFinish()
        }
    }
}
