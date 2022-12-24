//
//  MapBuilder.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import UIKit

final class MapBuilder {
    static func build() -> UIViewController {
        let vc = MapVC()
        let view = MapView()
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        let router = MapRouter()
        
        vc.view = view
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.view = view
        router.viewController = vc
        
        return vc
    }
}
