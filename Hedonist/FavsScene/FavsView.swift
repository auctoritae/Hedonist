//
//  FavsView.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import UIKit
import SnapKit

protocol FavsViewProtocol: AnyObject {
    func dispalyFavorites(viewModel: [Place])
    func displayFavorite(viewModel: Place)
    func removeFavorite(viewModel: Place)
}

final class FavsView: UIView {
    // MARK: - Variable
    var interactor: FavsInteractorProtocol?
    var router: FavsRouterProtocol?
    
    
    // MARK: - UI Variable
    private lazy var favsTitle: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = .systemFont(ofSize: 36, weight: .heavy)
        title.text = Titles.favSceneTitle
        title.textAlignment = .left
        title.numberOfLines = 1
        return title
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
    private func layoutUI() {
        backgroundColor = .systemBackground
        
        addSubview(favsTitle)
        
        favsTitle.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
    }
}


extension FavsView: FavsViewProtocol {
    // MARK: - Implementation
    func dispalyFavorites(viewModel: [Place]) {
        
    }
    
    
    func displayFavorite(viewModel: Place) {
        
    }
    
    
    func removeFavorite(viewModel: Place) {
        
    }
}
