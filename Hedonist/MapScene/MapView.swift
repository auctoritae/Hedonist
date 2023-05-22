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


final class CustomAnnotation: MKPointAnnotation {
    var landmark: Landmark
    
    init(landmark: Landmark) {
        self.landmark = landmark
        super.init()
    }
}


final class MapView: UIView {
    // MARK: - Variable
    var interactor: MapInteractorProtocol?
    var router: MapRouterProtocol?
    
    private var model: [Landmark]?
    private let locationManager = CLLocationManager()
    
    
    // MARK: - UI Variable
    private lazy var mapTitle: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = Fonts.header
        title.text = Titles.mapSceneTitle.uppercased()
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
        setupLocationManager()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    private func setDefaultRegion() {
        let location = CLLocationCoordinate2D(latitude: DefaultLocation.latitude, longitude: DefaultLocation.longitude)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: DefaultLocation.zoom, longitudinalMeters: DefaultLocation.zoom)
        mapView.setRegion(region, animated: false)
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
    func displayLandmarks(viewModel: [Landmark]) {
        model = viewModel
        model?.forEach { landmark in
            let annotation = CustomAnnotation(landmark: landmark)
            annotation.title = landmark.name
            annotation.subtitle = landmark.category
            annotation.coordinate = CLLocationCoordinate2D(latitude: landmark.lat ?? 0.0, longitude: landmark.long ?? 0.0)
            mapView.addAnnotation(annotation)
        }
    }
    
    
    func displayLandmark(viewModel: Landmark) {
        let landmark = viewModel
        router?.openLandmark(landmark: landmark)
    }
}


extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        guard let annotation = annotation as? CustomAnnotation else { return }
        let landmark = annotation.landmark
        interactor?.selectLandmark(request: landmark)
    }
}


extension MapView: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: DefaultLocation.zoom, longitudinalMeters: DefaultLocation.zoom)
        
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch manager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                
            case .restricted:
                setDefaultRegion()
            
            case .denied:
                 setDefaultRegion()
                
            case .authorizedAlways:
                setDefaultRegion()
                mapView.showsUserLocation = true
                locationManager.startUpdatingLocation()
                
            case .authorizedWhenInUse:
                setDefaultRegion()
                mapView.showsUserLocation = true
                locationManager.startUpdatingLocation()
                
            @unknown default: break
        }
    }
}
