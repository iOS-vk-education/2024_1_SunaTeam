//
//  AppState.swift
//  SunaTravel
//
//  Created by salfetka on 12.05.2025.
//


import Foundation
import FirebaseAuth
class AppState {
    static let shared = AppState()

    let profileViewModel: ProfileViewModel
    
    private var authListener: AuthStateDidChangeListenerHandle?

    private init() {
        let initialProfile = ProfileData(
            name: "",
            email: "",
            location: "",
            phoneNumber: "",
            rewardPointsCount: 0,
            travelTipsCount: 0,
            bucketListCount: 0
        )
        self.profileViewModel = ProfileViewModel(profile: initialProfile)

        authListener = Auth.auth().addStateDidChangeListener { _, user in
                if let uid = user?.uid {
                    self.profileViewModel.loadProfileData(for: uid)
                }
            }

    }
}
