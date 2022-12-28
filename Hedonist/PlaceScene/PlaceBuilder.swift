//
//  PlaceBuilder.swift
//  Hedonist
//
//  Created by a.lobanov on 12/28/22.
//

import UIKit

final class PlaceBuilder {
    static func build() -> UIViewController {
        let vc = PlaceVC()
        let view = PlaceView()
        let interactor = PlaceInteractor()
        let presenter = PlacePresenter()
        let router = PlaceRouter()
        
        vc.view = view
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.view = view
        router.viewController = vc
        
        return vc
    }
}
