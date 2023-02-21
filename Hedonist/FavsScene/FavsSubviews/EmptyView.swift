//
//  EmptyView.swift
//  Hedonist
//
//  Created by a.lobanov on 2/21/23.
//

import UIKit
import SnapKit

final class EmptyView: UIView {
    // MARK: - UI Variable
    private lazy var placeholder: UILabel = {
        let holder = UILabel()
        holder.textColor = .white
        holder.text = EmptyState.favsEmpty
        holder.font = Fonts.body
        holder.textAlignment = .center
        holder.numberOfLines = 0
        return holder
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
        addSubview(placeholder)
        placeholder.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
            $0.leading.trailing.equalToSuperview().inset(UIConstants.sidePadding).multipliedBy(2)
        }
    }
}
