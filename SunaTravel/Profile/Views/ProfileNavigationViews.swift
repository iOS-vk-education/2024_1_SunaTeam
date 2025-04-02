//
//  ProfileNavigationViews.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 24.12.2024.
//

import Foundation
import SwiftUI

struct BookmarksView: View {
    @State private var isShowingNotesView = false  // for navigation
    
    // MARK: option with ToolbarItem
    var body: some View {
        FavoritePlacesViewControllerWrapper()
            .navigationBarTitle("All Places", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CreateTripViewControllerWrapper()
                        .navigationBarItems(trailing:
                                                Button(action: {
                        isShowingNotesView = true
                        print("Notes button tapped")
                    }) {
//                        Image(systemName: "square.and.pencil")
                        Image(systemName: "checklist")
                    }
                                           )
                    ) {
                        Image(systemName: "plus")
                            .offset(x: 10)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: NotesView(), isActive: $isShowingNotesView) {
                        EmptyView()
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
