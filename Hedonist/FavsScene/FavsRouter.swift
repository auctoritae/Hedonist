//
//  FavsRouter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import Foundation

protocol FavsRouterProtocol: AnyObject {
    func openFavorite(place: Place)
}

final class FavsRouter: FavsRouterProtocol {
    // MARK: - Variable
    weak var viewController: FavsVC?
    
    
    // MARK: - Variable
    func openFavorite(place: Place) { }
}
