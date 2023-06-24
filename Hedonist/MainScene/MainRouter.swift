//
//  MainRouter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import Foundation

protocol MainRouterProtocol: AnyObject {
    func openLandmark(landmark: Landmark)
    func showOnboarding()
    func showError()
}

final class MainRouter: MainRouterProtocol {
    // MARK: - Variable
    weak var viewController: MainVC?
    
    
    // MARK: - Implementation
    func openLandmark(landmark: Landmark) {
        let scene = PlaceBuilder.build(place: landmark)
        viewController?.present(scene, animated: true)
    }
    
    
    func showOnboarding() {
        
    }
    
    
    func showError() {
        viewController?.presentAlert(message: Errors.fetchError)
    }
}
