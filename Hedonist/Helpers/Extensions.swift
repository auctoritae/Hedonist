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

    
    func setEmptyState(_ message: String) {
        let rectangle = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        let containerView = UIView(frame: rectangle)
        
        let messageLabel = UILabel()
        messageLabel.center = center
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        messageLabel.font = Fonts.body
        messageLabel.sizeToFit()
        
        addSubview(containerView)
        bringSubviewToFront(containerView)
        backgroundView = containerView
        
        containerView.addSubview(messageLabel)
        containerView.bringSubviewToFront(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-200)
        }
        
        separatorStyle = .none
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
