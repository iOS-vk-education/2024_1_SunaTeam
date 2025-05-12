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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                OnboardingContainerView(
                    isFirstLaunch: $isFirstLaunch,
                    viewModel: OnboardingViewModel())
            } else {
                RootView()
                    .environmentObject(authViewModel)
            }
        }
    }
}

struct RootView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                AppRootView()
                    .environmentObject(authViewModel)
            } else {
                SignInScreenView()
            }
        }
        .onAppear {
            authViewModel.checkAuthState()
        }
    }
}
