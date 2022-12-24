//
//  MainBuilder.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import UIKit

final class MainBuilder {
    static func build() -> UIViewController {
        let vc = MainVC()
        let view = MainView()
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        
        vc.view = view
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.view = view
        router.viewController = vc
        
        return vc
    }
}
