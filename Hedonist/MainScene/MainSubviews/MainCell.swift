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
    private lazy var gradientOverlay: UIView = {
        let gradient = UIView()
        gradient.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        gradient.layer.masksToBounds = true
        return gradient
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
        title.textColor = .gray
        title.font = .systemFont(ofSize: 14, weight: .regular)
        title.textAlignment = .left
        title.numberOfLines = 1
        return title
    }()
    
    private lazy var landmarkImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
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
        landmarkImage.image = UIImage(named: "Placeholder")
    }
    
    
    // MARK: - UI
    private func layoutUI() {
        contentView.backgroundColor = .systemBackground

        contentView.addSubview(landmarkImage)
        
        landmarkImage.addSubview(gradientOverlay)
        landmarkImage.bringSubviewToFront(gradientOverlay)
        
        gradientOverlay.addSubview(landmarkTitle)
        gradientOverlay.addSubview(landmarkSubtitle)
        gradientOverlay.bringSubviewToFront(landmarkTitle)
        gradientOverlay.bringSubviewToFront(landmarkSubtitle)
        
        landmarkImage.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.bottom.equalToSuperview().inset(5)
        }
        
        gradientOverlay.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        landmarkTitle.snp.makeConstraints {
            $0.leading.trailing.equalTo(landmarkSubtitle)
            $0.bottom.equalTo(landmarkSubtitle.snp.top).offset(-5)
        }
        
        landmarkSubtitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
}
