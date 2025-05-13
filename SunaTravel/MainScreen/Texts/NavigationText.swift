enum NavigationText {
    static func titles(for language: String) -> [String] {
        switch language {
        case "ru":
            return ["Главная", "Календарь", "Поиск", "Карта", "Профиль"]
        default:
            return ["Home", "Calendar", "Search", "Map", "Profile"]
        }
    }
}
