//
//  ProfileView.swift
//  Suna Travel
//
//  Created by salfetka on 13.11.2024.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.top)

                Text(viewModel.profile.name)
                    .font(.title2)
                Text(viewModel.profile.email)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
                HStack {
                    ProfileInfoItem(count: viewModel.profile.rewardPoints, title: "Reward Points")
                    Spacer()
                    ProfileInfoItem(count: viewModel.profile.travelTips, title: "Travel Tips")
                    Spacer()
                    ProfileInfoItem(count: viewModel.profile.bucketList, title: "Bucket List")
                }
                .padding()
                
                ProfileNavigationLinks()
                Spacer()
            }
            .padding()
            .navigationBarTitle("Profile", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: EditProfileView(viewModel: viewModel)) {
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
        let profileViewModel = ProfileViewModel(profile: ProfileData(
            name: "Leonardo",
            email: "leonardo@gmail.com",
            location: "Moscow, Russia",
            phoneNumber: "+1-222-333-44-55",
            rewardPoints: "360",
            travelTips: "238",
            bucketList: "473"
        ))

        ProfileView(viewModel: profileViewModel)
    }
}
