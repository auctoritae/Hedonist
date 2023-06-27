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
    func displayLandmark(viewModel: Landmark)
    func displaySearchFilter(viewModel: [Landmark], filter: String)
    func displayError()
}

final class MainView: UIView {
    // MARK: - Variable
    var interactor: MainInteractorProtocol?
    var router: MainRouterProtocol?
    
    private var search: [String] = SearchTitles.allCases.map { $0.rawValue }
    private var model: [Landmark]?

    
    // MARK: - UI Variable
    private lazy var mainTitle: UILabel = {
        let title = UILabel()
        title.textColor = .label
        title.font = Fonts.header
        title.text = Titles.mainSceneTitle.uppercased()
        title.textAlignment = .left
        title.numberOfLines = 1
        return title
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.cellId())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        
        let defaultSelection = IndexPath(item: 0, section: 0)
        collection.selectItem(at: defaultSelection, animated: false, scrollPosition: [])
        return collection
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(MainCell.self, forCellReuseIdentifier: MainCell.cellId())
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
        checkOnboarding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private
    private func checkOnboarding() {
        let onboarding = UserDefaults.standard.bool(forKey: Onboarding.key)
        if onboarding == false {
            router?.showOnboarding()
        }
    }
    
    
    // MARK: - UI
    private func layoutUI() {
        backgroundColor = .systemBackground
        
        addSubview(mainTitle)
        addSubview(collectionView)
        addSubview(tableView)
        
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(UIConstants.topPadding)
            $0.leading.equalToSuperview().offset(UIConstants.sidePadding)
            $0.trailing.equalToSuperview().offset(-UIConstants.sidePadding)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(mainTitle.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}


// MARK: - CollectionView extension
extension MainView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        search.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.cellId(), for: indexPath) as? SearchCell {
            cell.item = search[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 36)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = search[indexPath.row]
        interactor?.selectSearchFilter(filter: item)
    }
}


// MARK: - TableView extension
extension MainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.cellId(), for: indexPath) as? MainCell {
            cell.selectionStyle = .none
            cell.landmark = model?[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let landmark = model?[indexPath.row] {
            interactor?.selectLandmark(request: landmark)
        }
    }
}


// MARK: - Protocol implementation
extension MainView: MainViewProtocol {
    func displayLandmarks(viewModel: [Landmark]) {
        model = viewModel.shuffled()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
            self.checkOnboarding()
        }
    }
    
    
    func displayLandmark(viewModel: Landmark) {
        let landmark = viewModel
        router?.openLandmark(landmark: landmark)
    }
    
    
    func displaySearchFilter(viewModel: [Landmark], filter: String) {
        if let index = search.firstIndex(where: { $0 == filter }) {
            DispatchQueue.main.async {
                let filtered = viewModel.filter { $0.category == filter }
                self.model = filtered.shuffled()
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    
    func displayError() {
        router?.showError()
    }
}
