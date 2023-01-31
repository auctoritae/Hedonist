//
//  Helpers.swift
//  Hedonist
//
//  Created by a.lobanov on 1/7/23.
//

import Foundation

enum Titles {
    static let mainTabTitle = "Все"
    static let mainSceneTitle = "Места"
    static let favSceneTitle = "Избранное"
    static let mapSceneTitle = "Карта"
}


enum SearchTitles: String, CaseIterable {
    case all = "Все"
    case breakfasts = "Завтраки"
    case restaraunt = "Ресторан"
    case places = "Места"
    case drinks = "Бар"
}


enum UIConstants {
    static let sidePadding: CGFloat = 15
    static let topPadding: CGFloat = 20
}


enum DefaultLocation {
    static let latitude = 55.7582313
    static let longitude = 37.5949771
}


enum Errors {
    static let fetchError = "Ошибка загрузки.\nПожалуста, попробуйте еще раз"
    static let faillURL = "Неверный или устаревший адрес ссылки.\nВ ближайшее обновление все поправим😉"
    static let favsFail = "Произошла ошибка при добавлении в Избранное"
    static let phoneError = "У этого места нет актуального номера телефона в данный момент"
    static let serverError = "Ошибка обработки действия на сервере. Пожалуйста, попробуйте позднее"
}


enum AlertTitle {
    static let error = "😔😔😔"
    static let success = "🎉🎉🎉"
}


enum Alerts {
    static let addedToFavorites = "Добавлено в Избранное✌️"
    static let locationServices = "Похоже, у Вас не включена геолокация или отсутствует разрешение на ее использование. Вы можете изменить это в настройках Вашего iPhone"
}


enum EmptyState {
    static let favsEmpty = "У Вас пока еще нет мест в Избранном. \nПосмотрите, что есть в нашей подборке 🧐"
}
