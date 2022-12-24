//
//  MapView.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import UIKit
import SnapKit

protocol MapViewProtocol: AnyObject {
    
}

final class MapView: UIView {
    // MARK: - Variable
    var interactor: MapInteractorProtocol?
    var router: MapRouterProtocol?
    
    
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
        
    }
}


extension MapView: MapViewProtocol {
    
}
