//
//  MainView.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import UIKit
import SnapKit

protocol MainViewProtocol: AnyObject {
    func displayLandmarks(viewModel: [Landmark])
    func displayPlace(viewModel: Place)
    func displaySearchFilter()
    func displaySearchTyping()
}

final class MainView: UIView {
    // MARK: - Variable
    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?
    
    private var model: [Landmark]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    // MARK: - UI Variable
    private lazy var mainTitle: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = .systemFont(ofSize: 20, weight: .heavy)
        title.text = Titles.mainSceneTitle
        title.textAlignment = .left
        title.numberOfLines = 1
        return title
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(MainCell.self, forCellReuseIdentifier: MainCell.cellId())
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 60
        table.backgroundColor = .systemBackground
        table.separatorStyle = .none
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
        
        addSubview(mainTitle)
        addSubview(tableView)
        
        mainTitle.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(mainTitle.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}


extension MainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.cellId(), for: indexPath) as? MainCell {
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
}


extension MainView: MainViewProtocol {
    // MARK: - Implementation
    func displayLandmarks(viewModel: [Landmark]) {
        model = viewModel
    }
    
    
    func displayPlace(viewModel: Place) { }
    func displaySearchFilter() { }
    func displaySearchTyping() { }
}
