//
//  SunaTravelApp.swift
//  SunaTravel
//
//  Created by salfetka on 09.12.2024.
//

import SwiftUI

@main
struct SunaTravelApp: App {
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    @StateObject var profileViewModel = ProfileViewModel(profile: ProfileData(
            name: "Leonardo",
            email: "leonardo@gmail.com",
            location: "Moscow, Russia",
            phoneNumber: "+1-222-333-44-55",
            rewardPointsCount: 360,
            travelTipsCount: 238,
            bucketListCount: 473
    ))
    
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
