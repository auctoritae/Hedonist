//
//  PlaceRouter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/28/22.
//

import Foundation

protocol PlaceRouterProtocol: AnyObject {
    func openSMM(request: Place)
    func openCall(request: Place)
    func openMap(request: Place)
    func dismissView()
}

final class PlaceRouter: PlaceRouterProtocol {
    // MARK: - Variable
    weak var viewController: PlaceVC?
    
    
    // MARK: - Implementation
    func openSMM(request: Place) { }
    func openCall(request: Place) { }
    func openMap(request: Place) { }
    func dismissView() { }
}
