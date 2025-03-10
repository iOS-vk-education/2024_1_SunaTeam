//
//  SunaTravelApp.swift
//  SunaTravel
//
//  Created by salfetka on 09.12.2024.
//

import SwiftUI
import Firebase

@main
struct SunaTravelApp: App {
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    @StateObject var authViewModel = AuthViewModel()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                OnboardingContainerView(
                    isFirstLaunch: $isFirstLaunch,
                    viewModel: OnboardingViewModel())
            } else {
                ContentView()
            }
        }
    }
}
