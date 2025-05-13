//
//  NavigationBar.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 14.12.2024.
//

import SwiftUI
import UIKit
import Combine

fileprivate struct UIConstants {
    static let TabViewHeight: CGFloat = 70
    static let TabViewPadding: CGFloat = 10
}
    
final class NavigationBar: UITabBarController {
    private let authViewModel: AuthViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        
        AppSettings.shared.$currentLanguage
            .receive(on: RunLoop.main)
            .sink { [weak self] newLanguage in
                self?.updateLocalizedText(for: newLanguage)
            }
            .store(in: &cancellables)
    }
    
    private func setupTabs() {
        
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
        tabBar.tintColor = .systemBlue
        
        let homeView = UINavigationController(rootViewController: HomeViewController(profileViewModel: AppState.shared.profileViewModel))
        homeView.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let calendarView = UINavigationController(rootViewController: UIHostingController(rootView: MainView()))
        calendarView.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(systemName: "calendar"), tag: 1)
        
        let searchView = UINavigationController(rootViewController: SearchPlacesViewController())
        searchView.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle.fill"), tag: 2)
        
        let mapView = UINavigationController(rootViewController: UIHostingController(rootView: MapView().edgesIgnoringSafeArea(.all)))
        mapView.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 3)
        
        let profileView = UINavigationController(rootViewController: UIHostingController(rootView: ProfileView(viewModel: AppState.shared.profileViewModel)))
        profileView.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 4)
        
        viewControllers = [homeView, calendarView, searchView, mapView, profileView]
    }
    
    private func updateLocalizedText(for language: String) {
        
        tabBar.items?[0].title = NavigationText.home(for: language)
        tabBar.items?[1].title = NavigationText.calendar(for: language)
        tabBar.items?[2].title = NavigationText.search(for: language)
        tabBar.items?[3].title = NavigationText.map(for: language)
        tabBar.items?[4].title = NavigationText.profile(for: language)
    }
}

class EmptyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

struct AppRootView: UIViewControllerRepresentable {
    @EnvironmentObject var authViewModel: AuthViewModel

    func makeUIViewController(context: Context) -> NavigationBar {
        NavigationBar(authViewModel: authViewModel)
    }

    func updateUIViewController(_ uiViewController: NavigationBar, context: Context) {}
}
