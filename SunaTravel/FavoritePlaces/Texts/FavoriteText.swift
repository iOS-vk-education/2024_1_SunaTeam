struct FavoriteText {
    static func title (for language: String) -> String {
        switch language {
        case "rus": return "Все поездки"
        default: return "All places"
        }
    }
}
