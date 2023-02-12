//
//  PlaceView.swift
//  Hedonist
//
//  Created by a.lobanov on 12/28/22.
//

import UIKit
import SnapKit
import MapKit
import CoreData

protocol PlaceViewProtocol: AnyObject {
    func displayPlace(viewModel: Landmark, favorite: Bool)
    func displaySMM(viewModel: Landmark)
    func displayCall(viewModel: Landmark)
    func updateStatus(_ favorite: Bool)
    func closeScene()
}

class PlaceView: UIView, MKMapViewDelegate {
    // MARK: - Variable
    var interactor: PlaceInteractorProtocol?
    var router: PlaceRouterProtocol?
    
    private var isFavorite: Bool?
    private var symbolConfig = UIImage.SymbolConfiguration(pointSize: UIConstants.iconSize, weight: .medium, scale: .medium)

    var model: Landmark? {
        didSet {
            placeData()
        }
    }
    
    
    // MARK: - UI Variable
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        ]
        return gradient
    }()
    
    private lazy var overlay: UIView = {
        let container = UIView()
        container.layer.masksToBounds = true
        container.isUserInteractionEnabled = true
        return container
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "x.circle.fill", withConfiguration: symbolConfig), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var favoritesButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(favorites), for: .touchUpInside)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var smmButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera.circle.fill", withConfiguration: symbolConfig), for: .normal)
        button.addTarget(self, action: #selector(smm), for: .touchUpInside)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var callButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "phone.circle.fill", withConfiguration: symbolConfig), for: .normal)
        button.addTarget(self, action: #selector(call), for: .touchUpInside)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.delegate = self
        map.layer.cornerRadius = 8
        map.layer.masksToBounds = true
        return map
    }()
    
    private lazy var placeTitle: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.font = Fonts.placeTitle
        title.textAlignment = .left
        title.numberOfLines = 4
        return title
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = Fonts.body
        title.textAlignment = .left
        title.numberOfLines = 0
        return title
    }()
    
    private lazy var addressLabel: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = Fonts.body
        title.textAlignment = .left
        title.numberOfLines = 2
        return title
    }()
    
    private lazy var hoursLabel: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = Fonts.body
        title.textAlignment = .left
        title.numberOfLines = 1
        return title
    }()
    
    private lazy var placeImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        return image
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private
    private func placeData() {
        placeTitle.text = model?.name?.uppercased()
        placeImage.image = UIImage(named: "ABC")
        descriptionLabel.text = model?.descript
        addressLabel.text = model?.address
        hoursLabel.text = model?.workhours
        
        if let latitude = model?.lat, let longtitude = model?.long {
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 700, longitudinalMeters: 700)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
            
            mapView.setRegion(region, animated: false)
            mapView.addAnnotation(annotation)
        }
    }

    
    @objc private func close() {
        interactor?.close()
    }
    
    
    @objc private func favorites() {
        if let landmark = model {
            if isFavorite == true {
                interactor?.removeFromFavorites(request: landmark)
            } else {
                interactor?.addToFavorites(request: landmark)
            }
        }
    }
    
    
    @objc private func smm() {
        if let landmark = model {
            interactor?.openSMM(request: landmark)
        }
    }
    
    
    @objc private func call() {
        if let landmark = model {
            interactor?.call(request: landmark)
        }
    }
    
    
    // MARK: - UI
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        overlay.layer.addSublayer(gradient)
        gradient.frame = overlay.bounds
    }
    
    private func layoutUI() {
        backgroundColor = .systemBackground
        
        addSubview(placeImage)
        addSubview(mapView)
        
        addSubview(descriptionLabel)
        addSubview(addressLabel)
        addSubview(hoursLabel)
        
        addSubview(closeButton)
        addSubview(favoritesButton)
        addSubview(callButton)
        addSubview(smmButton)
        
        addSubview(placeTitle)
        
        placeImage.addSubview(overlay)
        placeImage.bringSubviewToFront(overlay)
        
        placeImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
        
        overlay.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(UIConstants.sidePadding)
        }
        
        favoritesButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(closeButton.snp.trailing).offset(10)
        }
        
        callButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.trailing.equalTo(smmButton.snp.leading).offset(-10)
        }
        
        smmButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.trailing.equalToSuperview().offset(-UIConstants.sidePadding)
        }
        
        placeTitle.snp.makeConstraints {
            $0.leading.equalTo(placeImage.snp.leading).offset(UIConstants.sidePadding)
            $0.trailing.equalTo(placeImage.snp.trailing).offset(-30)
            $0.bottom.equalTo(placeImage.snp.bottom)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(placeImage.snp.bottom).offset(UIConstants.topPadding)
            $0.leading.equalToSuperview().offset(UIConstants.sidePadding)
            $0.trailing.equalToSuperview().offset(-UIConstants.sidePadding)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(UIConstants.sidePadding)
            $0.leading.equalToSuperview().offset(UIConstants.sidePadding)
            $0.trailing.equalToSuperview().offset(-UIConstants.sidePadding)
        }
        
        hoursLabel.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(UIConstants.sidePadding)
            $0.trailing.equalToSuperview().offset(-UIConstants.sidePadding)
        }
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(hoursLabel.snp.bottom).offset(UIConstants.topPadding)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            $0.leading.equalToSuperview().offset(UIConstants.sidePadding)
            $0.trailing.equalToSuperview().offset(-UIConstants.topPadding)
        }
    }
}


// MARK: - Implementation
extension PlaceView: PlaceViewProtocol {
    func displayPlace(viewModel: Landmark, favorite: Bool) {
        model = viewModel
        isFavorite = favorite
    }
    
    
    func displaySMM(viewModel: Landmark) {
        router?.openSMM(from: viewModel)
    }
    
    
    func displayCall(viewModel: Landmark) {
        router?.openCall(from: viewModel)
    }
    
    
    func updateStatus(_ favorite: Bool) {
        isFavorite = favorite
    }
    
    
    func closeScene() {
        router?.close()
    }
}
