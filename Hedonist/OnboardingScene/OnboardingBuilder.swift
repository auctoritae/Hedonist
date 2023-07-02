//
//  OnboardingBuilder.swift
//  Hedonist
//
//  Created by Alexandr on 6/25/23.
//

import UIKit

final class OnboardingBuilder {
    static func build() -> UIViewController {
        let vc = OnboardingVC()
        let view = OnboardingView()
        let router = OnboardingRouter()
        
        vc.view = view
        view.router = router
        router.viewController = vc
        
        return vc
    }
}
