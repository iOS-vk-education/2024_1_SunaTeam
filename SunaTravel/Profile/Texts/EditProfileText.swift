struct EditProfileText {
    static func avatar (for language: String) -> String {
        switch language {
        case "rus": return "Изменить Изображение"
        default: return "Change Profile Picture"
        }
    }
    
    static func name (for language: String) -> String {
        switch language {
        case "rus": return "Имя"
        default: return "Name"
        }
    }
    
    static func email (for language: String) -> String {
        switch language {
        case "rus": return "Почта"
        default: return "Email"
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

