//
//  NavigationItemModel.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 18.12.2024.
//

import SwiftUI

struct NavigationItem {
    let title: String
    let systemImage: String
}

let navigationItems = [
        NavigationItem(title: "Home", systemImage: "house"),
        NavigationItem(title: "Calendar", systemImage: "calendar"),
        NavigationItem(title: "Search", systemImage: "magnifyingglass.circle.fill"),
        NavigationItem(title: "Messages", systemImage: "message"),
        NavigationItem(title: "Profile", systemImage: "person.circle")
    ]
