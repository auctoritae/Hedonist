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
    func displayPlace(viewModel: Landmark)
    func favoritesAction()
    func displaySMM(viewModel: Landmark)
    func displayCall(viewModel: Landmark)
}

class PlaceView: UIView, MKMapViewDelegate {
    // MARK: - Variable
    var interactor: PlaceInteractorProtocol?
    var router: PlaceRouterProtocol?
    
    var model: Landmark? {
        didSet {
            placeData()
        }
    }
    
    
    // MARK: - UI Variable
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor
        ]
        return gradient
    }()
    
    private lazy var overlay: UIView = {
        let container = UIView()
        container.layer.masksToBounds = true
        container.isUserInteractionEnabled = true
        return container
    }()
    
    private lazy var favoritesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.addTarget(self, action: #selector(favorites), for: .touchUpInside)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var smmButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.addTarget(self, action: #selector(smm), for: .touchUpInside)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var callButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "iphone.radiowaves.left.and.right"), for: .normal)
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
        title.font = .systemFont(ofSize: 24, weight: .bold)
        title.textAlignment = .left
        title.numberOfLines = 1
        return title
    }()
    
    private lazy var placeSubtitle: UILabel = {
        let title = UILabel()
        title.textColor = .lightGray
        title.font = .systemFont(ofSize: 16, weight: .regular)
        title.textAlignment = .left
        title.numberOfLines = 1
        return title
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = .systemFont(ofSize: 16, weight: .regular)
        title.textAlignment = .left
        title.numberOfLines = 0
        return title
    }()
    
    private lazy var addressLabel: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = .systemFont(ofSize: 16, weight: .bold)
        title.textAlignment = .left
        title.numberOfLines = 1
        return title
    }()
    
    private lazy var hoursLabel: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = .systemFont(ofSize: 16, weight: .bold)
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
        placeTitle.text = model?.name
        placeSubtitle.text = model?.category
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
    
    @objc private func favorites() {
        
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
        addSubview(favoritesButton)
        addSubview(callButton)
        addSubview(smmButton)
        addSubview(placeTitle)
        addSubview(placeSubtitle)
        
        placeImage.addSubview(overlay)
        placeImage.bringSubviewToFront(overlay)
        
        placeImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
        
        overlay.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        favoritesButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalTo(placeImage.snp.top).offset(UIConstants.sidePadding)
            $0.trailing.equalTo(placeImage.snp.trailing).offset(-UIConstants.sidePadding)
        }
        
        callButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalTo(placeImage.snp.top).offset(UIConstants.sidePadding)
            $0.leading.equalTo(placeImage.snp.leading).offset(UIConstants.sidePadding)
        }
        
        smmButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalTo(placeImage.snp.top).offset(UIConstants.sidePadding)
            $0.leading.equalTo(callButton.snp.trailing).offset(5)
        }
        
        placeTitle.snp.makeConstraints {
            $0.leading.trailing.equalTo(placeSubtitle)
            $0.bottom.equalTo(placeSubtitle.snp.top).offset(-4)
        }
        
        placeSubtitle.snp.makeConstraints {
            $0.leading.equalTo(placeImage.snp.leading).offset(UIConstants.sidePadding)
            $0.trailing.equalTo(placeImage.snp.trailing).offset(-UIConstants.sidePadding)
            $0.bottom.equalTo(placeImage.snp.bottom).offset(-UIConstants.sidePadding)
        }
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(placeImage.snp.bottom).offset(UIConstants.topPadding)
            $0.leading.equalToSuperview().offset(UIConstants.sidePadding)
            $0.trailing.equalToSuperview().offset(-UIConstants.sidePadding)
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom).offset(UIConstants.topPadding)
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
    }
}


// MARK: - Implementation
extension PlaceView: PlaceViewProtocol {
    func displayPlace(viewModel: Landmark) {
        model = viewModel
    }
    
    func favoritesAction() {
        
    }
    
    func displaySMM(viewModel: Landmark) {
        router?.openSMM(from: viewModel)
    }
    
    func displayCall(viewModel: Landmark) {
        router?.openCall(from: viewModel)
    }
}
