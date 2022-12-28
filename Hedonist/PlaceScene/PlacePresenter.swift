//
//  PlacePresenter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/28/22.
//

import Foundation

protocol PlacePresenterProtocol: AnyObject {
    
}

final class PlacePresenter: PlacePresenterProtocol {
    // MARK: - Variable
    weak var view: PlaceViewProtocol?
}
