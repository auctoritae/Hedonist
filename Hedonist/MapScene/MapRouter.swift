//
//  MapRouter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import Foundation

protocol MapRouterProtocol: AnyObject {
    func openLandmark(landmark: Landmark)
}

final class MapRouter: MapRouterProtocol {
    // MARK: - Variable
    weak var viewController: MapVC?
    
    
    // MARK: - Implementation
    func openLandmark(landmark: Landmark) {
        let scene = PlaceBuilder.build(place: landmark)
        viewController?.present(scene, animated: true)
    }
}
