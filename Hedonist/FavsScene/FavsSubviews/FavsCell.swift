//
//  FavsCell.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import UIKit
import SnapKit

final class FavsCell: UITableViewCell {
    // MARK: - Class function
    class func cellId() -> String {
        String(describing: FavsCell.self)
    }
    
    
    // MARK: - Variable
    var place: Place? {
        didSet {
            placeSetup()
        }
    }
    
    
    // MARK: - UI Variable
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        ]
        return gradient
    }()
    
    private lazy var overlay: UIView = {
        let container = UIView()
        container.layer.masksToBounds = true
        container.layer.addSublayer(gradient)
        return container
    }()
    
    private lazy var placeTitle: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.font = Fonts.cellTitle
        title.textAlignment = .left
        title.numberOfLines = 2
        return title
    }()
    
    private lazy var placeSubtitle: UILabel = {
        let title = UILabel()
        title.textColor = .lightGray
        title.font = Fonts.cellSubtitle
        title.textAlignment = .left
        title.numberOfLines = 1
        return title
    }()
    
    private lazy var placeImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    
    // MARK: - Init
    override func prepareForReuse() {
        super.prepareForReuse()
        placeTitle.text = nil
        placeSubtitle.text = nil
        placeImage.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private
    private func placeSetup() {
        placeTitle.text = place?.name
        placeSubtitle.text = place?.category
        placeImage.image = UIImage(named: "ABC")
    }
    
    
    // MARK: - UI
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradient.frame = overlay.bounds
    }
    
    
    private func layoutUI() {
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(placeImage)
        contentView.addSubview(placeTitle)
        contentView.addSubview(placeSubtitle)
        
        placeImage.addSubview(overlay)
        placeImage.bringSubviewToFront(overlay)
        
        placeImage.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(UIConstants.sidePadding)
            $0.top.bottom.equalToSuperview().inset(5)
        }
        
        overlay.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
    }
}

