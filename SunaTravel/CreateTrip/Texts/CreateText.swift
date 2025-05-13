struct CreateText {
    static func about (for language: String) -> String {
        switch language {
        case "rus": return "О Поездке"
        default: return "About Destination"
        }
    }
    
    static func description (for language: String) -> String {
        switch language {
        case "rus": return "Добавьте описание"
        default: return "Write description"
        }
    }
    static func name (for language: String) -> String {
        switch language {
        case "rus": return "Название поездки"
        default: return "Write a trip name"
        }
    }
    
    static func location (for language: String) -> String {
        switch language {
        case "rus": return "Место поездки"
        default: return "Write location"
        }
    }
    static func date (for language: String) -> String {
        switch language {
        case "rus": return "Дата поездки"
        default: return "Select date"
        }
    }
    
    static func save (for language: String) -> String {
        switch language {
        case "rus": return "Сохранить"
        default: return "Save"
        }
    }
}

