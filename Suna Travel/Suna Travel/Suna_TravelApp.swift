//
//  Suna_TravelApp.swift
//  Suna Travel
//
//  Created by salfetka on 03.11.2024.
//

import SwiftUI

@main
struct SunaTravelApp: App {
    @StateObject var profileData = ProfileData(
        name: "Leonardo",
        email: "leonardo@gmail.com",
        location: "Moscow, Russia",
        phoneNumber: "+1-222-333-44-55",
        rewardPoints: "360",
        travelTips: "238",
        bucketList: "473"
    )

    var body: some Scene {
        WindowGroup {
            ProfileView(profileData: profileData)
        }
    }
}

