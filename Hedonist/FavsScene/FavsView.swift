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
    func displayFavorite(viewModel: [Landmark])
}

final class FavsView: UIView {
    // MARK: - Variable
    var interactor: FavsInteractorProtocol?
    var router: FavsRouterProtocol?
    
    private var mock: [Place] = []
    
    private var model: [Place]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    // MARK: - UI Variable
    private lazy var favsTitle: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = Fonts.header
        title.text = Titles.favSceneTitle.uppercased()
        title.textAlignment = .left
        title.numberOfLines = 1
        return title
    }()
    
    private lazy var emptyState: EmptyView = {
        let empty = EmptyView()
        return empty
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(FavsCell.self, forCellReuseIdentifier: FavsCell.cellId())
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 215
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
    
    
    // MARK: - Private
    @objc private func updateFavorites() {
        interactor?.fetchFavorites()
    }
    
    
    // MARK: - UI
    private func layoutUI() {
        backgroundColor = .systemBackground
        
        addSubview(favsTitle)
        addSubview(tableView)
        addSubview(emptyState)
        
        favsTitle.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(favsTitle.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        emptyState.snp.makeConstraints {
            $0.edges.equalTo(tableView)
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateFavorites),
            name: .NotifyFavoritesUpdate,
            object: nil
        )
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
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: { cell.alpha = 1 }
        )
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let place = model?[indexPath.row] {
            mock.append(place)
            interactor?.selectFavorite(request: mock)
        }
    }
}


extension FavsView: FavsViewProtocol {
    // MARK: - Implementation
    func dispalyFavorites(viewModel: [Place]) {
        if viewModel.count > 0 {
            model = viewModel
            tableView.reloadData()
            emptyState.isHidden = true
        } else {
            emptyState.isHidden = false
        }
    }
    
    
    func displayFavorite(viewModel: [Landmark]) {
        mock.removeAll()
        mock = []
        guard let landmark = viewModel.first else { return }
        router?.openFavorite(place: landmark)
    }
}
