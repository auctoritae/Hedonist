//
//  MainInteractor.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    
}

final class MainInteractor: MainInteractorProtocol {
    // MARK: - Variable
    var presenter: MainPresenterProtocol?
    private var api: ApiManager
    
    
    // MARK: - Init
    required init(api: ApiManager) {
        self.api = api
    }
}
