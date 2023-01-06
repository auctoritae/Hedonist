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
    class func cellId() -> String {
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
    
    private lazy var landmarkTitle: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.font = .systemFont(ofSize: 18, weight: .bold)
        title.textAlignment = .left
        title.numberOfLines = 1
        return title
    }()
    
    private lazy var landmarkSubtitle: UILabel = {
        let title = UILabel()
        title.textColor = .lightGray
        title.font = .systemFont(ofSize: 14, weight: .regular)
        title.textAlignment = .left
        title.numberOfLines = 1
        return title
    }()
    
    private lazy var landmarkImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
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
        landmarkImage.image = UIImage(named: "ABC")
    }
    
    
    // MARK: - UI
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = overlay.bounds
    }
    
    private func layoutUI() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(landmarkImage)
        
        landmarkImage.addSubview(overlay)
        landmarkImage.bringSubviewToFront(overlay)
        
        overlay.addSubview(landmarkTitle)
        overlay.addSubview(landmarkSubtitle)
        overlay.bringSubviewToFront(landmarkTitle)
        overlay.bringSubviewToFront(landmarkSubtitle)
        
        landmarkImage.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.bottom.equalToSuperview().inset(5)
        }
        
        overlay.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        landmarkTitle.snp.makeConstraints {
            $0.leading.trailing.equalTo(landmarkSubtitle)
            $0.bottom.equalTo(landmarkSubtitle.snp.top).offset(-2)
        }
        
        landmarkSubtitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.bottom.equalToSuperview().offset(-15)
        }
    }
}
