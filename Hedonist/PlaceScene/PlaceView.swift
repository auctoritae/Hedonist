//
//  PlaceView.swift
//  Hedonist
//
//  Created by a.lobanov on 12/28/22.
//

import UIKit
import SnapKit

protocol PlaceViewProtocol: AnyObject {
    func displayPlace(viewModel: Place)
    func addToFavoritesAlert(viewModel: Place)
    func removeFromFavoritesAlert(viewModel: Place)
    func displaySMM(viewModel: Place)
    func displayCall(viewModel: Place)
    func displayMap(viewModel: Place)
    func dismissView()
}

class PlaceView: UIView {
    // MARK: - Variable
    var interactor: PlaceInteractorProtocol?
    var router: PlaceRouterProtocol?
    
    
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


extension PlaceView: PlaceViewProtocol {
    func displayPlace(viewModel: Place) { }
    func addToFavoritesAlert(viewModel: Place) { }
    func removeFromFavoritesAlert(viewModel: Place) { }
    func displaySMM(viewModel: Place) { }
    func displayCall(viewModel: Place) { }
    func displayMap(viewModel: Place) { }
    func dismissView() { }
}
