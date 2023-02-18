//
//  MainCell.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import UIKit
import SnapKit
import AlamofireImage

final class MainCell: UITableViewCell {
    // MARK: - Class function
    static func cellId() -> String {
        String(describing: MainCell.self)
    }
    
    
    // MARK: - Variable
    var landmark: Landmark? {
        didSet {
            landmarkSetup()
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
    
    private lazy var landmarkTitle: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.font = Fonts.cellTitle
        title.textAlignment = .left
        title.numberOfLines = 2
        return title
    }()
    
    private lazy var landmarkSubtitle: UILabel = {
        let title = UILabel()
        title.textColor = .lightGray
        title.font = Fonts.cellSubtitle
        title.textAlignment = .left
        title.numberOfLines = 1
        return title
    }()
    
    private lazy var landmarkImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    
    // MARK: - Init
    override func prepareForReuse() {
        super.prepareForReuse()
        landmarkTitle.text = nil
        landmarkSubtitle.text = nil
        landmarkImage.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private
    private func landmarkSetup() {
        landmarkTitle.text = landmark?.name
        landmarkSubtitle.text = landmark?.category
        
        if let reference = landmark?.image, let url = URL(string: reference) {
            landmarkImage.af.setImage(withURL: url, placeholderImage: UIImage(named: "Placeholder"))
        }
    }
    
    
    // MARK: - UI
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradient.frame = overlay.bounds
    }
    
    
    private func layoutUI() {
        contentView.backgroundColor = .systemBackground
        contentView.clipsToBounds = true
        
        contentView.addSubview(landmarkImage)
        contentView.addSubview(landmarkTitle)
        contentView.addSubview(landmarkSubtitle)
        
        landmarkImage.addSubview(overlay)
        landmarkImage.bringSubviewToFront(overlay)
        
        landmarkImage.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(UIConstants.sidePadding)
            $0.top.bottom.equalToSuperview().inset(5)
        }
        
        overlay.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        landmarkTitle.snp.makeConstraints {
            $0.leading.trailing.equalTo(landmarkSubtitle)
            $0.bottom.equalTo(landmarkSubtitle.snp.top).offset(-4)
        }
        
        landmarkSubtitle.snp.makeConstraints {
            $0.leading.equalTo(landmarkImage.snp.leading).offset(UIConstants.sidePadding)
            $0.trailing.equalTo(landmarkImage.snp.trailing).offset(-UIConstants.sidePadding)
            $0.bottom.equalTo(landmarkImage.snp.bottom).offset(-UIConstants.sidePadding)
        }
    }
}
