//
//  ProfileViewModel.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 24.12.2024.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var profile: ProfileData
    @Published var isSuccessMessageShowed: Bool = false
    
    init(profile: ProfileData) {
        self.profile = profile
    }
    
    func saveChanges(name: String, email: String, location: String, phoneNumber: String, avatar: UIImage?) {
        profile.name = name
        profile.email = email
        profile.location = location
        profile.phoneNumber = phoneNumber
        profile.avatar = avatar
        isSuccessMessageShowed = true
    }
}
