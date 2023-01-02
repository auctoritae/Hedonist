//
//  FavsView.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import UIKit
import SnapKit

protocol FavsViewProtocol: AnyObject {
    func dispalyFavorites(viewModel: [Place])
    func displayFavorite(viewModel: Place)
    func removeFavorite(viewModel: Place)
}

final class FavsView: UIView {
    // MARK: - Variable
    var interactor: FavsInteractorProtocol?
    var router: FavsRouterProtocol?
    
    
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


extension FavsView: FavsViewProtocol {
    func dispalyFavorites(viewModel: [Place]) { }
    func displayFavorite(viewModel: Place) { }
    func removeFavorite(viewModel: Place) { }
}
