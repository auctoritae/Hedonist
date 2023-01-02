//
//  MainRouter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import Foundation

protocol MainRouterProtocol: AnyObject {
    func openPlace(place: Place)
}

final class MainRouter: MainRouterProtocol {
    // MARK: - Variable
    weak var viewController: MainVC?
    
    
    // MARK: - Implementation
    func openPlace(place: Place) { }
}
