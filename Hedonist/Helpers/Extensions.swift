//
//  Extensions.swift
//  Hedonist
//
//  Created by a.lobanov on 1/21/23.
//

import UIKit
import SnapKit

// MARK: - UITableView extensions
extension UITableView {
    
    func removeExcessCells () {
        tableFooterView = UIView(frame: .zero)
    }

    
    func setEmptyState(_ emptyState: String) {
        separatorStyle = .none
        let rectangle = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        let containerView = UIView(frame: rectangle)
        
        let placeholder = UIImageView()
        placeholder.image = UIImage(named: "Logo")
        placeholder.contentMode = .scaleAspectFit
        
        let message = UILabel()
        message.center = center
        message.text = emptyState
        message.numberOfLines = 0
        message.textColor = .white
        message.textAlignment = .center
        message.font = Fonts.body
        message.sizeToFit()
        
        addSubview(containerView)
        bringSubviewToFront(containerView)
        backgroundView = containerView
        
        containerView.addSubview(message)
        containerView.addSubview(placeholder)
        containerView.bringSubviewToFront(message)
        containerView.bringSubviewToFront(placeholder)
        
        placeholder.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-100)
            $0.width.height.equalTo(100)
        }
        
        message.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(placeholder.snp.bottom).offset(UIConstants.topPadding)
        }
    }
    
    
    func restore() {
        backgroundView = nil
        separatorStyle = .none
    }
}


// MARK: - UIViewController extensions
extension UIViewController {
    func presentAlert(message: String) {
        DispatchQueue.main.async {
            let label = UILabel()
            label.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            label.textColor = UIColor.white
            label.font = Fonts.body
            label.textAlignment = .center
            label.text = message
            label.alpha = 1.0
            label.layer.cornerRadius = 4
            label.clipsToBounds = true
            
            self.view.addSubview(label)
            label.snp.makeConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
                $0.leading.trailing.equalToSuperview().inset(UIConstants.sidePadding)
                $0.height.equalTo(40)
            }
            
            UIView.animate(withDuration: 3.5, delay: 0.1, options: .curveEaseOut, animations: {
                label.alpha = 0.0
            }, completion: { (isCompleted) in
                label.removeFromSuperview()
            })
        }
    }
}
