//
//  ProfileNavigationLinks.swift
//  Suna Travel
//
//  Created by salfetka on 26.11.2024.
//

import Foundation
import SwiftUI

struct ProfileNavigationLinks: View {
    var body: some View {
        List {
            ProfileLink(title: "Bookmarks", destination: BookmarksView(), image: "bookmark.circle")
            ProfileLink(title: "Previous Trips", destination: PreviousTripsView(), image: "globe.europe.africa")
            ProfileLink(title: "Settings", destination: SettingsView(), image: "gearshape")
            ProfileLink(title: "About app", destination: VersionView(), image: "info.circle")
        }
        .listStyle(.plain)
    }
}

struct ProfileLinkConsts {
    static let listButtonImageSize = 18.0
    static let listButtonSize = 52.0
    static let titleVerticalPadding = 5.0
    static let titleCornerRadius = 3.0
}

struct ProfileLink<Destination: View>: View {
    let title: String
    let destination: Destination
    let image: String
    
    var body: some View {
        NavigationLink(destination: destination) {
            Image(systemName: image)
                .resizable()
                .frame(width: ProfileLinkConsts.listButtonImageSize, height: ProfileLinkConsts.listButtonImageSize)
            Text(title)
                .padding(.vertical, ProfileLinkConsts.titleVerticalPadding)
                .background(Color.white)
                .cornerRadius(ProfileLinkConsts.titleCornerRadius)
                .multilineTextAlignment(.leading)

        }
        .frame(height: ProfileLinkConsts.listButtonSize)
    }
}
