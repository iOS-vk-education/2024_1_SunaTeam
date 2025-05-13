struct SignInText {
    static func title (for language: String) -> String {
        switch language {
        case "rus": return "Войдите сейчас"
        default: return "Sign in now"
        }
    }
    
    static func text (for language: String) -> String {
        switch language {
        case "rus": return "Войдите в аккаунт, чтобы продолжить пользоваться приложением"
        default: return "Please sign in to continue our app"
        }
    }
    
    static func email (for language: String) -> String {
        switch language {
        case "rus": return "Почта"
        default: return "Email"
        }
    }
    
    static func password (for language: String) -> String {
        switch language {
        case "rus": return "Пароль"
        default: return "Password"
        }
    }
    
    static func signup (for language: String) -> String {
        switch language {
        case "rus": return "Регистрация"
        default: return "Sign up"
        }
    }
    
    static func dont (for language: String) -> String {
        switch language {
        case "rus": return "Нет аккаунта?"
        default: return "Don't have an account?"
        }
    }
    
    static func signin (for language: String) -> String {
        switch language {
        case "rus": return "Войти"
        default: return "Sign in"
        }
    }
    
    static func forget (for language: String) -> String {
        switch language {
        case "rus": return "Забыли пароль?"
        default: return "Forget password?"
        }
    }
    
    static func invalidEmail (for language: String) -> String {
        switch language {
        case "rus": return "Неправильный формат почты"
        default: return "Invalid email format"
        }
    }
    
    static func invalidPassword (for language: String) -> String {
        switch language {
        case "rus": return "Пароль не может быть пустым"
        default: return "Password cannot be empty"
        }
    }
}

