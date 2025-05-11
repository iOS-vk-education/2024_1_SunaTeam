//
//  ProfileNavigationViews.swift
//  SunaTravel
//
//  Created by Иван Тарасюк on 24.12.2024.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct BookmarksView: View {
    var body: some View {
        FavoritePlacesViewControllerWrapper()
            .navigationBarTitle("All Places", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
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
    @ObservedObject private var appSettings = AppSettings.shared
    @State private var showingLogoutAlert = false
    @State private var isLoggedOut = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                VStack(alignment: .leading, spacing: 8) {
                    Text("APPEARANCE")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    HStack {
                        Image(systemName: appSettings.isDarkMode ? "moon.fill" : "sun.max.fill")
                        Text("Dark Mode")
                        Spacer()
                        Toggle("", isOn: $appSettings.isDarkMode)
                            .labelsHidden()
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
                // Секция языка
                VStack(alignment: .leading, spacing: 8) {
                    Text("LANGUAGE")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    Picker("Language", selection: $appSettings.currentLanguage) {
                        Text("English").tag("eng")
                        Text("Русский").tag("rus")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 370)
            Button(action: {
                showingLogoutAlert = true
            }) {
                Text("Logout")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding()
        }
        .alert(isPresented: $showingLogoutAlert) {
            Alert(
                title: Text("Logout"),
                message: Text("Are you sure you want to logout?"),
                primaryButton: .destructive(Text("Logout")) {
                    logout()
                },
                secondaryButton: .cancel()
            )
        }
        .fullScreenCover(isPresented: $isLoggedOut) {
            SignInScreenView()
        }
    }
    
    private func logout() {
        do {
            try Auth.auth().signOut()
            isLoggedOut = true
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

class AppSettings: ObservableObject {
    static let shared = AppSettings()
    
    @Published var isDarkMode: Bool = false {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
            updateAppTheme()
        }
    }
    
    @Published var currentLanguage: String = "eng" {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: "appLanguage")
            // Здесь можно добавить обновление локализации
        }
    }
    
    init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        updateAppTheme()
    }
    
    func updateAppTheme() {
        DispatchQueue.main.async {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            windowScene?.windows.forEach { window in
                window.overrideUserInterfaceStyle = self.isDarkMode ? .dark : .light
            }
            
            // Настройка NavigationBar
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.shadowColor = .clear
            UINavigationBar.appearance().standardAppearance = appearance
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AppSettings())
    }
}

struct VersionView: View {
    var body: some View {
        Text("Version 52.52")
            .font(.title)
    }
}
