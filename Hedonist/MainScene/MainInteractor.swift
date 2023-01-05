//
//  MainInteractor.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    func fetchLandmarks()
    func selectLandmark(request: Landmark)
    func selectSearchFilter()
    func didSearchTyping()
}

final class MainInteractor: MainInteractorProtocol {
    // MARK: - Variable
    var presenter: MainPresenterProtocol?
    private var api: ApiManager
    
    
    // MARK: - Init
    required init(api: ApiManager) {
        self.api = api
    }
    
    
    // MARK: - Implementation
    func fetchLandmarks() {
        api.fetchData { result in
            if let data = result {
                let response = data.record
                self.presenter?.presentLandmarks(response: response)
            }
        }
    }
    
    
    func selectLandmark(request: Landmark) { }
    func selectSearchFilter() { }
    func didSearchTyping() { }
}
