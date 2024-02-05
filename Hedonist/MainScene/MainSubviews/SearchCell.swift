//
//  SearchCell.swift
//  Hedonist
//
//  Created by a.lobanov on 1/7/23.
//

import UIKit
import SnapKit

final class SearchCell: UICollectionViewCell {
    // MARK: - Class function
    static func cellId() -> String {
        String(describing: SearchCell.self)
    }
    
    static func cellSize(title: String) -> CGSize {
        let textSize = (title as NSString).size()
        let width = textSize.width + (textSize.width / 2 ) + (12 * 2)
        return CGSize(width: width, height: 36)
    }
    
    
    // MARK: - Variable
    var item: String? {
        didSet {
            titleSetup()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            changeColor()
        }
    }
    
    
    // MARK: - UI Variable
    private lazy var categoryTitle: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.font = Fonts.bubble
        title.textAlignment = .center
        title.numberOfLines = 1
        return title
    }()
    
    
    // MARK: - Init
    override func prepareForReuse() {
        super.prepareForReuse()
        item = nil
        categoryTitle.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutUI()
    }
    
    
    // MARK: - Private
    private func titleSetup() {
        categoryTitle.text = item?.uppercased()
    }
    
    private func changeColor() {
        if isSelected {
            contentView.backgroundColor = UIColor(red: 0.829, green: 0.169, blue: 0.169, alpha: 1)
            categoryTitle.textColor = .white
        } else {
            contentView.backgroundColor = .lightGray
            categoryTitle.textColor = .black
        }
    }
    
    
    // MARK: - UI
    private func layoutUI() {
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(categoryTitle)
        categoryTitle.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(5)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
    }
}
