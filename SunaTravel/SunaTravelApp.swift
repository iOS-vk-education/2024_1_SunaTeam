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
    @StateObject private var appSettings = AppSettings.shared
    
    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                AppRootView()
                    .environmentObject(appSettings)
                    .preferredColorScheme(appSettings.isDarkMode ? .dark : .light)
                    .onAppear {
                        appSettings.updateAppTheme()
                    }
            } else {
                SignInScreenView()
            }
        }
        .animation(.easeInOut, value: authViewModel.isAuthenticated)
    }
}
