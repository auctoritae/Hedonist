//
//  MainView.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import UIKit
import SnapKit

protocol MainViewProtocol: AnyObject {
    func displayLandmarks(viewModel: [Landmark])
    func displayPlace(viewModel: Place)
    func displaySearchFilter()
    func displaySearchTyping()
}

final class MainView: UIView {
    // MARK: - Variable
    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI
    private func layoutUI() {
        backgroundColor = .label
    }
}


extension MainView: MainViewProtocol {
    func displayLandmarks(viewModel: [Landmark]) { }
    func displayPlace(viewModel: Place) { }
    func displaySearchFilter() { }
    func displaySearchTyping() { }
}
