struct MainText {
    static func select (for language: String) -> String {
        switch language {
        case "rus": return "Выберите Дату"
        default: return "Select Date"
        }
    }
    
    static func schedule (for language: String) -> String {
        switch language {
        case "rus": return "Мой График"
        default: return "My Schedule"
        }
    }
}

