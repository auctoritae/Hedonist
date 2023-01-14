//
//  PlaceRouter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/28/22.
//

import Foundation

protocol PlaceRouterProtocol: AnyObject {
    func openSMM(from: Landmark)
    func openCall(from: Landmark)
    func openMap(from: Landmark)
}

final class PlaceRouter: PlaceRouterProtocol {
    // MARK: - Variable
    weak var viewController: PlaceVC?
    
    
    // MARK: - Implementation
    func openSMM(from: Landmark) {
        
    }
    
    func openCall(from: Landmark) {
        
    }
    
    func openMap(from: Landmark) {
        
    }
}
