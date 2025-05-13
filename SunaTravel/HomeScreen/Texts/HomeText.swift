struct HomeText {
    static func title (for language: String) -> String {
        switch language {
        case "rus": return "Вспомните свои\n яркие моменты"
        default: return "Remember the\n bright moments"
        }
    }
    
    static func destinationLabel (for language: String) -> String {
        switch language {
        case "rus": return "Ваши Поездки"
        default: return "Your Destinations"
        }
    }
    
    static func viewAll (for language: String) -> String {
        switch language {
        case "rus": return "Показать все"
        default: return "View all"
        }
    }
    
    static func location (for language: String) -> String {
        switch language {
        case "rus": return "Город"
        default: return "Location"
        }
    }
    
    static func number (for language: String) -> String {
        switch language {
        case "rus": return "Телефон"
        default: return "Phone Number"
        }
    }
    
    static func save (for language: String) -> String {
        switch language {
        case "rus": return "Сохранить"
        default: return "Save"
        }
    }
}

