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
    
    var model: Landmark? {
        didSet {
            placeData()
        }
    }
    
    
    // MARK: - UI Variable
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.9).cgColor
        ]
        return gradient
    }()
    
    private lazy var overlay: UIView = {
        let container = UIView()
        container.layer.masksToBounds = true
        container.layer.insertSublayer(gradient, at: 0)
        return container
    }()
    
    private lazy var mapView: UIView = {
        let map = UIView()
        map.layer.cornerRadius = 8
        map.layer.masksToBounds = true
        map.backgroundColor = .lightGray
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
    
    
    // MARK: - UI
    private func placeData() {
        placeTitle.text = model?.name
        placeSubtitle.text = model?.category
        placeImage.image = UIImage(named: "ABC")
        descriptionLabel.text = model?.descript
        addressLabel.text = model?.address
        hoursLabel.text = model?.workhours
    }
    
    
    // MARK: - UI    
    private func layoutUI() {
        backgroundColor = .systemBackground
        
        addSubview(placeImage)
        addSubview(mapView)
        addSubview(descriptionLabel)
        addSubview(addressLabel)
        addSubview(hoursLabel)
        
        placeImage.addSubview(overlay)
        placeImage.bringSubviewToFront(overlay)
        
        overlay.addSubview(placeTitle)
        overlay.addSubview(placeSubtitle)
        overlay.bringSubviewToFront(placeTitle)
        overlay.bringSubviewToFront(placeSubtitle)
        
        placeImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.45)
        }
        
        overlay.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        placeTitle.snp.makeConstraints {
            $0.leading.trailing.equalTo(placeSubtitle)
            $0.bottom.equalTo(placeSubtitle.snp.top).offset(-4)
        }
        
        placeSubtitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.bottom.equalToSuperview().offset(-15)
        }
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(placeImage.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalToSuperview().multipliedBy(0.15)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        hoursLabel.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
    }
}


// MARK: - Implementation
extension PlaceView: PlaceViewProtocol {
    func displayPlace(viewModel: Landmark) {
        model = viewModel
    }
    
    
    func addToFavoritesAlert(viewModel: Landmark) { }
    func removeFromFavoritesAlert(viewModel: Landmark) { }
    func displaySMM(viewModel: Landmark) { }
    func displayCall(viewModel: Landmark) { }
    func displayMap(viewModel: Landmark) { }
    func dismissView() { }
}
