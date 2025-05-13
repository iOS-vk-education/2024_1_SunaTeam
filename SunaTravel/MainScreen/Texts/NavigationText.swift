struct NavigationText {
    static func home (for language: String) -> String {
        switch language {
        case "rus": return "Главная"
        default: return "Home"
        }
    }
    
    static func calendar (for language: String) -> String {
        switch language {
        case "rus": return "Календарь"
        default: return "Calendar"
        }
    }
    
    static func search (for language: String) -> String {
        switch language {
        case "rus": return "Поиск"
        default: return "Search"
        }
    }
    
    static func map (for language: String) -> String {
        switch language {
        case "rus": return "Карта"
        default: return "Map"
        }
    }
    
    static func profile (for language: String) -> String {
        switch language {
        case "rus": return "Профиль"
        default: return "Profile"
        }
    }
}

