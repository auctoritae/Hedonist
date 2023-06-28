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
import AlamofireImage

extension Notification.Name {
    static let NotifyFavoritesUpdate = Notification.Name("NotifyFavoritesUpdate")
}

protocol PlaceViewProtocol: AnyObject {
    func displayPlace(viewModel: Landmark, favorite: Bool)
    func displayCall(viewModel: Landmark)
    func updateStatus(_ favorite: Bool)
    func closeScene()
}

class PlaceView: UIView, MKMapViewDelegate {
    // MARK: - Variable
    var interactor: PlaceInteractorProtocol?
    var router: PlaceRouterProtocol?
    
    private var isFavorite: Bool?
    
    var model: Landmark? {
        didSet {
            placeData()
        }
    }
    
    
    // MARK: - UI Variable
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.black.withAlphaComponent(0.7).cgColor,
            UIColor.black.withAlphaComponent(0.1).cgColor,
            UIColor.black.withAlphaComponent(1.0).cgColor
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
        button.setImage(UIImage(named: "xMark")?.withTintColor(.white), for: .normal)
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
    
    private lazy var callButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "callMark")?.withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(call), for: .touchUpInside)
        button.tintColor = .white
        button.contentMode = .scaleAspectFit
        return button
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
        descriptionLabel.text = model?.descript
        addressLabel.text = model?.address
        hoursLabel.text = model?.workhours
        
        if let reference = model?.image, let url = URL(string: reference) {
            placeImage.af.setImage(withURL: url)
        } else {
            placeImage.image = UIImage(named: "Placeholder")
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
        addSubview(descriptionLabel)
        addSubview(addressLabel)
        addSubview(hoursLabel)
        addSubview(closeButton)
        addSubview(favoritesButton)
        addSubview(callButton)
        addSubview(placeTitle)
        
        placeImage.addSubview(overlay)
        placeImage.bringSubviewToFront(overlay)
        
        placeImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.45)
        }
        
        overlay.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(UIConstants.sidePadding - 5)
        }
        
        favoritesButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.top.equalTo(closeButton.snp.top)
            $0.trailing.equalTo(callButton.snp.leading)
        }
        
        callButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.top.equalTo(closeButton.snp.top)
            $0.trailing.equalToSuperview().offset(-UIConstants.sidePadding)
        }
        
        placeTitle.snp.makeConstraints {
            $0.leading.equalTo(placeImage.snp.leading).offset(UIConstants.sidePadding)
            $0.trailing.equalTo(placeImage.snp.trailing).offset(-20)
            $0.bottom.equalTo(placeImage.snp.bottom).offset(10)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(placeImage.snp.bottom).offset(UIConstants.topPadding)
            $0.leading.equalToSuperview().offset(UIConstants.sidePadding)
            $0.trailing.equalToSuperview().offset(-UIConstants.sidePadding)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(UIConstants.topPadding + 10)
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
    
    func displayPlace(viewModel: Landmark, favorite: Bool) {
        model = viewModel
        isFavorite = favorite
        
        if favorite == true {
            favoritesButton.setImage(UIImage(named: "favMark")?.withTintColor(.white), for: .normal)
        } else {
            favoritesButton.setImage(UIImage(named: "notfavMark")?.withTintColor(.white), for: .normal)
        }
    }
    
    
    func displayCall(viewModel: Landmark) {
        router?.openCall(from: viewModel)
    }
    
    
    func updateStatus(_ favorite: Bool) {
        isFavorite = favorite
        NotificationCenter.default.post(name: .NotifyFavoritesUpdate, object: nil)
        
        if favorite == true {
            favoritesButton.setImage(UIImage(named: "favMark")?.withTintColor(.white), for: .normal)
            router?.presentFavAlert()
        } else {
            favoritesButton.setImage(UIImage(named: "notfavMark")?.withTintColor(.white), for: .normal)
        }
    }
    
    
    func closeScene() {
        router?.close()
    }
}
