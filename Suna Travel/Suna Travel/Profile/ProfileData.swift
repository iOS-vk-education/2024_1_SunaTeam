//
//  ProfileData.swift
//  Suna Travel
//
//  Created by salfetka on 20.11.2024.
//

import SwiftUI
import Combine

class ProfileData: ObservableObject {
    @Published var name: String
    @Published var email: String
    @Published var location: String
    @Published var phoneNumber: String
    @Published var rewardPoints: String
    @Published var travelTips: String
    @Published var bucketList: String
    
    init(name: String, email: String, location: String, phoneNumber: String, rewardPoints: String, travelTips: String, bucketList: String) {
        self.name = name
        self.email = email
        self.location = location
        self.phoneNumber = phoneNumber
        self.rewardPoints = rewardPoints
        self.travelTips = travelTips
        self.bucketList = bucketList
    }
}
