struct SettingsText {
    static func settingsAppearance (for language: String) -> String {
        switch language {
        case "rus": return "ТЕМА ПРИЛОЖЕНИЯ"
        default: return "APPEARANCE"
        }
    }
    
    static func settingsMode (for language: String) -> String {
        switch language {
        case "rus": return "Темная Тема"
        default: return "Dark Mode"
        }
    }
    
    static func settingsLanguage (for language: String) -> String {
        switch language {
        case "rus": return "ЯЗЫК"
        default: return "LANGUAGE"
        }
    }
    
    static func settingsLogout (for language: String) -> String {
        switch language {
        case "rus": return "Выйти"
        default: return "Logout"
        }
    }
    
    static func settingsAlertTitle (for language: String) -> String {
        switch language {
        case "rus": return "Выход"
        default: return "Logout"
        }
    }
    
    static func settingsAlertText (for language: String) -> String {
        switch language {
        case "rus": return "Вы уверены, что хотите выйти?"
        default: return "Are you sure you want to logout?"
        }
    }
    
    static func settingsCancel (for language: String) -> String {
        switch language {
        case "rus": return "Отмена"
        default: return "Cancel"
        }
    }
}

