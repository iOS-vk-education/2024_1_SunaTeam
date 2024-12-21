//
//  NavigationBar.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 14.12.2024.
//

import SwiftUI

fileprivate struct UIConstants {
    static let TabViewHeight: CGFloat = 70
    static let TabViewPadding: CGFloat = 10
}

struct NavigationBar: View {
    var body: some View {
        TabView {
            ForEach(navigationItems, id: \.title) { item in
                Text("")
                    .tabItem {
                        Image(systemName: item.systemImage)
                        Text(item.title)
                    }
            }
        }
        .accentColor(.blue)
        .frame(height: UIConstants.TabViewHeight)
        .padding(.bottom, UIConstants.TabViewPadding)
    }
}

struct BottomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar()
            .previewLayout(.sizeThatFits)
    }
}
