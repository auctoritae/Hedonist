//
//  FavsPresenter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import Foundation

protocol FavsPresenterProtocol: AnyObject {
    
}

final class FavsPresenter: FavsPresenterProtocol {
    // MARK: - Variable
    weak var view: FavsViewProtocol?
}
