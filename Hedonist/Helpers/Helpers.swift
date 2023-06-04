//
//  Helpers.swift
//  Hedonist
//
//  Created by a.lobanov on 1/7/23.
//

import UIKit

enum Titles {
    static let mainTabTitle = "All"
    static let mainSceneTitle = "Feed"
    static let favSceneTitle = "Favorites"
    static let mapSceneTitle = "Map"
}


enum Fonts {
    static let header = UIFont(name: "JetBrainsMono-SemiBold", size: 44)
    static let placeTitle = UIFont(name: "JetBrainsMono-SemiBold", size: 30)
    static let cellTitle = UIFont(name: "JetBrainsMono-Regular", size: 22)
    static let cellSubtitle = UIFont(name: "JetBrainsMono-Light", size: 16)
    static let body = UIFont(name: "JetBrainsMono-Light", size: 14)
    static let bubble = UIFont(name: "JetBrainsMono-SemiBold", size: 12)
}


enum SearchTitles: String, CaseIterable {
    case all = "all"
    case breakfasts = "breakfast"
    case restaraunt = "restaurants"
    case places = "landmarks"
    case drinks = "drinks"
    case city = "city"
}


enum UIConstants {
    static let sidePadding: CGFloat = 20
    static let topPadding: CGFloat = 25
    static let iconSize: CGFloat = 32
}


enum DefaultLocation {
    static let latitude = 37.983810
    static let longitude = 23.727539
    static let zoom: Double = 1000
}


enum Errors {
    static let fetchError = "Fetch error.\nPlease try again"
    static let faillURL = "URL failure.\nDon't worry, it will be fixed soon"
    static let favsFail = "Something went wrong - try to add place to Favorites again"
    static let phoneError = "There is no cell number for this place"
    static let serverError = "Server error. Please try again later"
}


enum AlertTitle {
    static let error = "😔"
    static let success = "🎉"
}


enum Alerts {
    static let addedToFavorites = "Added to favorites"
    static let locationServices = "Looks like that location is off or disallowed. You can change it in the your device settings."
}


enum EmptyState {
    static let favsEmpty = "You have no favorites now.\nTake a look what we have in the Feed🧐"
}
