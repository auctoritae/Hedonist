//
//  MainRouter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import UIKit

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
        scene.modalPresentationStyle = .overFullScreen
        scene.modalTransitionStyle = .coverVertical
        viewController?.present(scene, animated: true)
    }
    
    
    func showOnboarding() {
        let onboarding = OnboardingBuilder.build()
        viewController?.present(onboarding, animated: true) {
            UserDefaults.standard.set(true, forKey: Onboarding.key)
        }
    }
    
    
    func showError() {
        viewController?.presentAlert(message: Errors.fetchError)
    }
}
