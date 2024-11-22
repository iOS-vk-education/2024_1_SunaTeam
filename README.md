# 2024_1_SunaTeam
Проект команды SunaTeam по курсу "Мобильный разработчик на iOS" от VK
**Состав команды:**
1. [**Зиманов Михаил**](<https://github.com/nekoposer>)(<https://t.me/aleshovich>)
2. [**Тарасюк Иван**](<https://github.com/IvanTarasiuk>)(<https://t.me/vanechka0812>)
3. [**Чечина Лилия**](<https://github.com/Lilia-Chechina>)(<https://t.me/flowers_queen>)
4. [**Попова Юлия(ментор)**](<https://t.me/yuzaaasl>)
5. [**Курганова Александра(ментор)**](<https://t.me/axndkgn>)

## 1. Общая информация
**Название проекта:** Трекер путешествий (рабочее название)  
**Цель приложения:** Создать удобный инструмент для путешественников, позволяющий планировать поездки, хранить воспоминания и просматривать историю путешествий через визуальные элементы, такие как фотографии и карты.  
**Целевая аудитория:**  
- Основная: Частые путешественники, которые хотят систематизировать свои поездки, сохранять фотографии, заметки и планировать будущее.
- Второстепенная: Люди, путешествующие реже (например, один раз в год), но желающие сохранить впечатления и делиться воспоминаниями.

**Платформа:** iOS  
**Технологии:**  
- **Frontend:** SwiftUI/UIKit
- **Backend:** firebase
- **Cloud Storage:** CloudKit/swiftData
- **Geolocation API:** для отображения и записи посещённых мест
- **Image Processing Libraries:** для обработки изображений и создания коллажей

**Монетизация:** Отсутствует (приложение бесплатное)

---

## 2. Основной функционал

1. **Авторизация:**
   - Регистрация и авторизация через email.
   - Возможность восстановления пароля через email.
   - Личный профиль пользователя с возможностью редактирования личных данных (имя, фото, email и пр.).

2. **Коллекция путешествий:**
   - Главный экран приложения отображает коллекцию поездок пользователя.
   - Каждая поездка представлена в виде карточки, на которой отображаются:
     - **Название поездки** (указанное пользователем).
     - **Дата поездки**.
     - **Фон карточки** — первая фотография, загруженная пользователем для данной поездки.
   - При нажатии на карточку открывается детализированный экран с полной информацией о поездке:
     - Фотографии, видео, описание впечатлений, информация о проживании и посещённых достопримечательностях.

3. **Добавление новой поездки:**
   - Кнопка "Добавить" в правом верхнем углу главного экрана открывает форму создания поездки.
   - В форме пользователь указывает:
     - Название поездки.
     - Даты поездки (начало и окончание).
     - Местоположение (страна, город).
     - Описание поездки.
     - Загружает фотографии и видео.

4. **Функция "Воспоминания":**
   - Генерация **коллажей** из фотографий поездки.
   - Возможность создания видео-слайдшоу с музыкой и подписями.
   - Уведомления о годовщинах поездок (через push-уведомления).

---

## 3. Нижняя навигационная панель (горизонтальное меню)

1. **Профиль:**
   - Раздел, где пользователь может редактировать свою личную информацию (имя, фото, email, пароль).
   - Отображение статистики пользователя: количество поездок, количество посещённых стран и городов.

2. **Поездки:**
   - Отображение всех поездок пользователя в виде коллекции.
   - Сверху экрана — **переключатель** между "Совершённые" и "Запланированные" поездки.
   - Карточки поездок содержат:
     - Название.
     - Даты.
     - Фон — первая фотография поездки.

3. **Карта:**
   - Интерактивная карта мира, на которой отмечены все города/страны, где пользователь был.
   - При нажатии на маркер на карте открывается краткая информация о поездке и ссылка на детализированную карточку поездки.

4. **Настройки:**
   - Раздел для управления параметрами приложения:
     - Редактирование профиля.
     - Настройки уведомлений (push-уведомления, воспоминания).
     - Конфиденциальность.
     - Общие параметры приложения.

---

## 4. Дополнительные функции

1. **Поиск по поездкам:**
   - В верхней части главного экрана и экрана "Поездки" будет присутствовать строка поиска.
   - Поиск будет осуществляться по названию поездки или по дате.

2. **Сортировка поездок:**
   - Возможность сортировки списка поездок по:
     - Дате (от новых к старым и наоборот).
     - Алфавиту.
     - Географическому расположению (по странам).

3. **Анимации:**
   - Плавные анимации при переходе между экранами (например, при открытии детализированной карточки поездки).
   - Анимации при прокрутке списка поездок.

---

## 5. Распределение обязанностей

1. **Карта**
   - [**Тарасюк Иван**](<https://github.com/IvanTarasiuk>)
2. **Галерея**
   - [**Зиманов Михаил**](<https://github.com/nekoposer>)
3. **Карточки поездок**
   - [**Чечина Лилия**](<https://github.com/Lilia-Chechina>)

## 6. Ресурсы команды

1. **Таск-трекер**
   - [**trello**](<https://trello.com/b/KY57Lynp/suna-team>)
2. **Дизайн**
   - [**figma**](<https://www.figma.com/design/cY14cq1navkbsxjGHUHB04/Untitled?node-id=0-1&t=tuOSnYz5tOpdrxwD-1>)
