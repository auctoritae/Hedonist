//
//  OnboardingRouter.swift
//  Hedonist
//
//  Created by Alexandr on 6/24/23.
//

import Foundation

protocol OnboardingRouterProtocol: AnyObject {
    func close()
}

final class OnboardingRouter: OnboardingRouterProtocol {
    // MARK: - Variable
    weak var viewController: OnboardingVC?
    
    
    // MARK: - Implementation
    func close() {
        viewController?.dismiss(animated: true)
    }
}
