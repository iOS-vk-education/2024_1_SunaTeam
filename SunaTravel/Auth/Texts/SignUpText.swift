struct SignUpText {
    static func title (for language: String) -> String {
        switch language {
        case "rus": return "Зарегистрируйтесь сейчас"
        default: return "Sign up now"
        }
    }
    
    static func text (for language: String) -> String {
        switch language {
        case "rus": return "Для создания аккаунта заполните информацию"
        default: return "Please fill the details and create an account"
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
    
    static func already (for language: String) -> String {
        switch language {
        case "rus": return "Уже есть аккаунт?"
        default: return "Already have an account?"
        }
    }
    
    static func signin (for language: String) -> String {
        switch language {
        case "rus": return "Войти"
        default: return "Sign in"
        }
    }
}

