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
    @EnvironmentObject var settings: AppSettings

    var body: some View {
        FavoritePlacesViewControllerWrapper()
            .navigationBarTitle(ProfileText.listPlaces(for: settings.currentLanguage), displayMode: .inline)
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
    @EnvironmentObject var settings: AppSettings

    var body: some View {
        SearchViewControllerWrapper()
            .navigationBarTitle(ProfileText.listSearch(for: settings.currentLanguage), displayMode: .inline)
    }
}

struct SettingsView: View {
    @ObservedObject private var appSettings = AppSettings.shared
    @State private var showingLogoutAlert = false
    @State private var isLoggedOut = false
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                VStack(alignment: .leading, spacing: 8) {
                    Text(SettingsText.settingsAppearance(for: settings.currentLanguage))
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    HStack {
                        Image(systemName: appSettings.isDarkMode ? "moon.fill" : "sun.max.fill")
                        Text(SettingsText.settingsMode(for: settings.currentLanguage))
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
                    Text(SettingsText.settingsLanguage(for: settings.currentLanguage))
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
                Text(SettingsText.settingsLogout(for: settings.currentLanguage))
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
                title: Text(SettingsText.settingsAlertTitle(for: settings.currentLanguage)),
                message: Text(SettingsText.settingsAlertText(for: settings.currentLanguage)),
                primaryButton: .destructive(Text(SettingsText.settingsLogout(for: settings.currentLanguage))) {
                    logout()
                },
                secondaryButton: .cancel(Text(SettingsText.settingsCancel(for: settings.currentLanguage)))
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
