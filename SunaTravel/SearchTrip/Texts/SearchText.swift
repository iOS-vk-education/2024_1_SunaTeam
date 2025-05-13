struct SearchText {
    static func search (for language: String) -> String {
        switch language {
        case "rus": return "Поиск поездок"
        default: return "Search for places"
        }
    }
}
