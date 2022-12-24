//
//  MainPresenter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    
}

final class MainPresenter: MainPresenterProtocol {
    // MARK: - Variable
    weak var view: MainViewProtocol?
}
