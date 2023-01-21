//
//  MapView.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation

protocol MapViewProtocol: AnyObject {
    func displayLandmarks(viewModel: [Landmark])
    func displayLandmark(viewModel: Landmark)
}

final class MapView: UIView, MKMapViewDelegate {
    // MARK: - Variable
    var interactor: MapInteractorProtocol?
    var router: MapRouterProtocol?
    
    
    // MARK: - UI Variable
    private lazy var mapTitle: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = .systemFont(ofSize: 36, weight: .heavy)
        title.text = Titles.mapSceneTitle
        title.textAlignment = .left
        title.numberOfLines = 1
        return title
    }()
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.delegate = self
        map.layer.masksToBounds = true
        return map
    }()
    
    
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
        
        addSubview(mapTitle)
        addSubview(mapView)
        
        mapTitle.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalToSuperview().offset(UIConstants.sidePadding)
            $0.trailing.equalToSuperview().offset(-UIConstants.sidePadding)
        }
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(mapTitle.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}


extension MapView: MapViewProtocol {
    // MARK: - Implementation
    func displayLandmarks(viewModel: [Landmark]) { }
    func displayLandmark(viewModel: Landmark) { }
}
