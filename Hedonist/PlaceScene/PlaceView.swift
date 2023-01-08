//
//  PlaceView.swift
//  Hedonist
//
//  Created by a.lobanov on 12/28/22.
//

import UIKit
import SnapKit

protocol PlaceViewProtocol: AnyObject {
    func displayPlace(viewModel: Landmark)
    func addToFavoritesAlert(viewModel: Landmark)
    func removeFromFavoritesAlert(viewModel: Landmark)
    func displaySMM(viewModel: Landmark)
    func displayCall(viewModel: Landmark)
    func displayMap(viewModel: Landmark)
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
        backgroundColor = .systemBackground
    }
}


extension PlaceView: PlaceViewProtocol {
    // MARK: - Implementation
    func displayPlace(viewModel: Landmark) { }
    func addToFavoritesAlert(viewModel: Landmark) { }
    func removeFromFavoritesAlert(viewModel: Landmark) { }
    func displaySMM(viewModel: Landmark) { }
    func displayCall(viewModel: Landmark) { }
    func displayMap(viewModel: Landmark) { }
    func dismissView() { }
}
