//
//  ProfileNavigationViews.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 24.12.2024.
//

import Foundation
import SwiftUI

struct BookmarksView: View {
    var body: some View {
        FavoritePlacesViewControllerWrapper()
            .navigationBarTitle("All Places", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Кнопка "+" для перехода
                    NavigationLink(destination: CreateTripViewControllerWrapper()) {
                        Image(systemName: "plus")
                    }
                }
            }
    }
}

struct PreviousTripsView: View {
    var body: some View {
        SearchViewControllerWrapper()
            .navigationBarTitle("Search Places", displayMode: .inline)
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings Screen")
            .font(.title)
    }
}

struct VersionView: View {
    var body: some View {
        Text("Version 52.52")
            .font(.title)
    }
}
