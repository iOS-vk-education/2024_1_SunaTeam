//
//  ProfileNavigationLinks.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 24.12.2024.
//

import Foundation
import SwiftUI

struct ProfileNavigationLinks: View {
    @EnvironmentObject var settings: AppSettings

    var body: some View {
        List {
            ProfileLink(title: ProfileText.listPlaces(for: settings.currentLanguage), destination: BookmarksView(), image: "bookmark.circle")
            ProfileLink(title: ProfileText.listSearch(for: settings.currentLanguage), destination: PreviousTripsView(), image: "globe.europe.africa")
            ProfileLink(title: ProfileText.listSettings(for: settings.currentLanguage), destination: SettingsView().environmentObject(AppSettings.shared), image: "gearshape")
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
                .background(.background)
                .cornerRadius(ProfileLinkConsts.titleCornerRadius)
                .multilineTextAlignment(.leading)

        }
        .frame(height: ProfileLinkConsts.listButtonSize)
    }
}
