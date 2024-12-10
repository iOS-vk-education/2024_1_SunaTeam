//
//  ProfileView.swift
//  Suna Travel
//
//  Created by salfetka on 13.11.2024.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    private let avatarSize = 100.0
    @ObservedObject var profileData: ProfileData
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: avatarSize, height: avatarSize)
                    .padding(.top)

                Text(profileData.name)
                    .font(.title2)
                Text(profileData.email)
                    .font(.subheadline)
                    .padding(.bottom)
                    .foregroundColor(.gray)
                
                HStack {
                    ProfileInfoItem(count: profileData.rewardPoints, title: "Reward Points")
                    Spacer()
                    ProfileInfoItem(count: profileData.travelTips, title: "Travel Tips")
                    Spacer()
                    ProfileInfoItem(count: profileData.bucketList, title: "Bucket List")
                }
                .padding()
                
                ProfileNavigationLinks()
                Spacer()
            }
            .padding()
            .navigationBarTitle("Profile", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: EditProfileView(profileData: profileData)) {
                        Image(systemName: "pencil")
                    }
                }
            }
        }
    }
}

struct ProfileInfoItem: View {
    let count: String
    let title: String
    var body: some View {
        VStack {
            Text(count)
                .font(.title2)
            Text(title)
                .font(.footnote)
                .foregroundColor(.orange)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let profileData = ProfileData(name: "Leonardo", email: "leonardo@gmail.com", location: "Moscow, Russia", phoneNumber: "+19993332211", rewardPoints: "360", travelTips: "238", bucketList: "473")

        ProfileView(profileData: profileData)
    }
}
