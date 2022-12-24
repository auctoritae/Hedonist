//
//  MapPresenter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import Foundation

protocol MapPresenterProtocol: AnyObject {
    
}

final class MapPresenter: MapPresenterProtocol {
    // MARK: - Variable
    weak var view: MapViewProtocol?
}
