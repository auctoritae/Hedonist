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
     func presentAlert(title: String, message: String) {
          DispatchQueue.main.async {
               let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default))
               alert.modalPresentationStyle = .overFullScreen
               alert.modalTransitionStyle = .crossDissolve
               self.present(alert, animated: true)
          }
     }
}
