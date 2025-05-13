struct ProfileText {
    static func title (for language: String) -> String {
        switch language {
        case "rus": return "Профиль"
        default: return "Profile"
        }
    }
    
    static func listPlaces (for language: String) -> String {
        switch language {
        case "rus": return "Все Поездки"
        default: return "All Places"
        }
    }
    
    static func listSearch (for language: String) -> String {
        switch language {
        case "rus": return "Поиск Поездок"
        default: return "Search Trips"
        }
    }
    
    static func listSettings (for language: String) -> String {
        switch language {
        case "rus": return "Настройки"
        default: return "Settings"
        }
    }
}

