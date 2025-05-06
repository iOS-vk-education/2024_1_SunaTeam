//
//  ProfileView.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 24.12.2024.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            if let avatar = viewModel.profile.avatar {
                Image(uiImage: avatar)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding(.top)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .padding(.top)
            }
            
            Text(viewModel.profile.name)
                .font(.title2)
                .foregroundColor(.primary)
            Text(viewModel.profile.email)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom)
                .foregroundColor(.secondary)
            
            //MARK: – Статистика – на будущее
            ProfileNavigationLinks()
            Spacer()
        }
        .padding()
        .navigationBarTitle("Profile", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: EditProfileView(viewModel: viewModel)) {
                    Image(systemName: "pencil")
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

struct ProfileInfoItem: View {
    let count: Int
    let title: String
    
    var body: some View {
        VStack {
            Text("\(count)")
                .font(.title2)
                .foregroundColor(.primary)
            Text(title)
                .font(.footnote)
                .foregroundColor(.orange)
        }
    }
}
