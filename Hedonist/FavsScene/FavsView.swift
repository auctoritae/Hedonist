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
    
    private var model: [Place]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    
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
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(FavsCell.self, forCellReuseIdentifier: FavsCell.cellId())
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 125
        table.backgroundColor = .systemBackground
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.removeExcessCells()
        return table
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
        addSubview(tableView)
        
        favsTitle.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(favsTitle.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}


extension FavsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FavsCell.cellId(), for: indexPath) as? FavsCell {
            cell.selectionStyle = .none
            cell.place = model?[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
}


extension FavsView: FavsViewProtocol {
    // MARK: - Implementation
    func dispalyFavorites(viewModel: [Place]) {
        model = viewModel
        tableView.reloadData()
    }
    
    
    func displayFavorite(viewModel: Place) {
        
    }
    
    
    func removeFavorite(viewModel: Place) {
        
    }
}
