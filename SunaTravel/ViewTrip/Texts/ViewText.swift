struct ViewText {
    static func about (for language: String) -> String {
        switch language {
        case "rus": return "О Поездке"
        default: return "About Destination"
        }
    }
    
    static func more (for language: String) -> String {
        switch language {
        case "rus": return "Показать еще"
        default: return "Read more"
        }
    }
}
